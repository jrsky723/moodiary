# The Cloud Functions for Firebase SDK to create Cloud Functions and set up triggers.
from firebase_functions import firestore_fn
from openai import OpenAI
from firebase_admin import initialize_app
import math
import os

app = initialize_app()


def correct_to_unit_circle(valence, arousal):
    # Calculate the magnitude of the vector (valence, arousal)
    magnitude = math.sqrt(valence**2 + arousal**2)
    # If the magnitude is greater than 1, scale down to fit within the unit circle
    valence /= magnitude
    arousal /= magnitude
    return valence, arousal


@firestore_fn.on_document_created(
    document="users/{userId}/diaries/{pushId}", secrets=["OPENAI_API_KEY"]
)
def analyze_emotion_diary(
    event: firestore_fn.Event[firestore_fn.DocumentSnapshot | None],
) -> None:
    """Listens for new documents to be added to /users/{userId}/diaries.
    When a new diary entry is added, OpenAI is used to analyze the emotion of the text.
    """

    if event.data is None:
        return
    try:
        diary_content = event.data.get("content")
    except KeyError:
        # No "original" field
        return

    # Fetch the OpenAI API key from Secret Manager

    client = OpenAI(api_key=os.environ.get("OPENAI_API_KEY"))
    # Use OpenAI API to analyze the text
    try:
        response = client.chat.completions.create(
            model="gpt-3.5-turbo",
            response_format={"type": "json_object"},
            messages=[
                {
                    "role": "system",
                    "content": "The following is a conversation with an AI assistant to analyze the emotion of a text.",
                },
                {
                    "role": "system",
                    "content": (
                        "You are an AI assistant trained to analyze diary entries and extract emotional values based on the Circumplex model of affect. "
                        "The Circumplex model categorizes emotions along two dimensions: valence (pleasant-unpleasant) and arousal (high-low), both ranging from -1 to 1. "
                        "The values should be strictly within the unit circle, meaning the condition x^2 + y^2 <= 1 must always be met. "
                        "Analyze the diary entry and provide the emotional values in the following JSON format: "
                        '{"valence": value, "arousal": value}. Ensure the valence and arousal values adhere to the unit circle constraint.'
                    ),
                },
                {
                    "role": "user",
                    "content": """
                    June 26, 2024, WednesdayI woke up at 7 AM as usual. 
                    I started the day with a cup of coffee and some stretching.
                    From 9 AM, I communicated with my team on Slack and conducted a code review.
                    In the morning, I completed the code review and some simple bug fixes.For lunch, I ordered Chinese food.
                    In the afternoon, I planned and worked on implementing new features.
                    I finished my work by 5 PM and did some home training to unwind.
                    Dinner was light with a salad and grilled chicken breast.At night, I worked on my personal project and studied new technologies.
                    I had a productive day and went to bed feeling accomplished.
                    I look forward to another great day tomorrow.
                    """,
                },
                {
                    "role": "assistant",
                    "content": "{'valence': 0.7, 'arousal': 0.2}",
                },
                {
                    "role": "user",
                    "content": """
                    June 26, 2024, WednesdayI woke up at 7 AM as usual.
                    I started the day with a cup of coffee and some stretching.
                    From 9 AM, I communicated with my team on Slack and conducted a code review.
                    In the morning, I completed the code review and some simple bug fixes.For lunch, I ordered Chinese food.
                    In the afternoon, I planned and worked on implementing new features. 
                    I finished my work by 5 PM and did some home training to unwind. Dinner was light with a salad and grilled chicken breast.
                    At night, I worked on my personal project and studied new technologies.
                    I had a productive day and went to bed, but I felt a bit lonely.
                    I worry that if I continue living like this, I'll spend my whole life just developing software, without a girlfriend or marriage, and end up living alone.
                    """,
                },
                {
                    "role": "assistant",
                    "content": "{'valence': -0.3, 'arousal': -0.2}",
                },
                # 사용자의 일기를 입력
                {
                    "role": "user",
                    "content": diary_content,
                },
            ],
        )
        analysis_result = response.choices[0].message.content
        dict = eval(analysis_result)
        valence = dict["valence"]
        arousal = dict["arousal"]
        xOffset, yOffset = correct_to_unit_circle(valence, arousal)
        print(f"Emotion analysis result: valence={valence}, arousal={arousal}")
        # Update the document with the analysis result
        event.data.reference.update({"xOffset": xOffset, "yOffset": yOffset})

    except Exception as e:
        print(f"Error while analyzing emotion with OpenAI: {e}")
