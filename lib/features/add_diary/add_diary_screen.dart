import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodiary/common/widgets/circle_avatar.dart';
import 'package:moodiary/common/widgets/p_info_button.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/add_diary/widgets/diary_container.dart';

class AddDiaryScreen extends StatefulWidget {
  const AddDiaryScreen({super.key});

  @override
  State<AddDiaryScreen> createState() => _AddDiaryScreenState();
}

class _AddDiaryScreenState extends State<AddDiaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            pInfoButton(
              icon: FontAwesomeIcons.gear,
              size: Sizes.size24,
              color: Colors.grey.shade600,
            ),
            Row(
              children: [
                Text(
                  '4월 3일 수요일',
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                pInfoButton(
                  icon: FontAwesomeIcons.caretDown,
                  size: Sizes.size16,
                  color: Colors.grey.shade900,
                ),
              ],
            ),
            pInfoButton(
              icon: FontAwesomeIcons.xmark,
              size: Sizes.size24,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(
            child: DiaryContainer(
              crossAxisAlignment: CrossAxisAlignment.center,
              text: "어떤 하루였나요?",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SCircleAvatar(),
                  SCircleAvatar(),
                  SCircleAvatar(),
                  SCircleAvatar(),
                  SCircleAvatar(),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DiaryContainer(
              text: "감정",
              child: GridView.builder(
                padding: const EdgeInsets.all(
                  Sizes.size10,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 11 / 10,
                ),
                itemCount: 16,
                itemBuilder: (BuildContext context, int index) {
                  // Replace this with your CircleAvatar widget
                  return Column(
                    children: [
                      const SCircleAvatar(),
                      Gaps.v2,
                      Text(
                        emotions[index],
                        style: const TextStyle(
                          fontSize: Sizes.size12,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DiaryContainer(
              text: "사람",
              child: GridView.builder(
                padding: const EdgeInsets.all(
                  Sizes.size10,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 11 / 10,
                ),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  // Replace this with your CircleAvatar widget
                  return Column(
                    children: [
                      const SCircleAvatar(),
                      Gaps.v2,
                      Text(
                        people[index],
                        style: const TextStyle(
                          fontSize: Sizes.size12,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DiaryContainer(
              text: "수면",
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 1,
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.grey.shade500,
                    surfaceTintColor: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        Sizes.size5,
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "수면을 기록해주세요",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DiaryContainer(
              text: "일기",
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(
                    Sizes.size5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    maxLines: 1,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "내용을 입력해주세요",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: Sizes.size14,
                      ),
                    ),
                    cursorColor: Colors.green.shade300,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DiaryContainer(
              text: "수면",
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 1,
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.grey.shade500,
                    surfaceTintColor: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        Sizes.size5,
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "수면을 기록해주세요",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<String> emotions = [
  "신나는",
  "편안한",
  "뿌듯한",
  "기대되는",
  "행복한",
  "의욕적인",
  "설레는",
  "상쾌한",
  "우울한",
  "외로운",
  "불안한",
  "슬픈",
  "화난",
  "부담되는",
  "짜증나는",
  "피곤한",
];

List<String> people = [
  "친구",
  "가족",
  "애인",
  "지인",
  "안 만남",
];
