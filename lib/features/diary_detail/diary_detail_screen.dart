import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/diary_detail/insight_pages.dart';
import 'package:moodiary/features/diary_detail/widgets/image_slider.dart';
import 'package:moodiary/features/diary_detail/widgets/mood_analysis_card.dart';
import 'package:moodiary/features/diary_detail/widgets/text_page_view.dart.dart';

// 전역 변수로 예시 데이터 제공
final List<String> wordList = [
  '코딩',
  '공부',
  '운동',
  '휴식',
  '잠',
  '여자친구',
  '없다',
  '슬프다',
];

const String DiarySampleText = """
오늘은 코딩을 열심히 했다.
오랜만에 새로운 프로젝트를 시작해서 흥미진진했다. 
복잡한 알고리즘 문제를 풀었을 때의 성취감이 정말 컸다.

공부도 열심히 했다.
내일 있을 시험을 대비해서 밤늦게까지 공부했다.
특히 데이터베이스와 네트워크 부분을 집중적으로 복습했다.
모든 내용을 다 이해하지는 못했지만, 그래도 많이 배운 것 같다.

운동도 열심히 했다.
오후에 헬스장에서 땀을 많이 흘렸다.
런닝머신에서 30분 뛰고, 근력 운동도 했다.
운동 후에는 몸이 가벼워지는 느낌이 들어서 기분이 좋았다.

휴식도 열심히 했다.
오후에는 잠깐 낮잠도 자고, 좋아하는 책도 읽었다.
카페에서 커피 한 잔 마시며 조용한 시간을 보냈다.
이런 시간이 정말 소중하게 느껴졌다.

잠도 열심히 잤다.
요즘 잠이 부족해서 그런지 피곤했다.
오늘은 일찍 잠자리에 들기로 했다.
푹 자고 나면 내일은 더 활기차게 보낼 수 있을 것 같다.

여자친구는 없다.
요즘 친구들이 여자친구 얘기를 많이 해서 그런지 나도 외롭다.
연애를 하고 싶다는 생각이 들지만, 아직은 준비가 안 된 것 같다.
그래도 가끔은 누군가와 함께하고 싶은 마음이 커진다.

그래서 슬프다.
이런 감정을 느끼는 내가 조금은 불안하고, 외로움을 느끼지만
지금은 나 자신을 더 발전시키는 것이 중요하다고 생각한다.
슬픔도 나의 일부분이기에 잘 받아들이고 극복해 나가야겠다.
   """;

const List<String> imageUrls = [
  'https://picsum.photos/300/200',
  'https://picsum.photos/1980/1980',
  'https://picsum.photos/1920/1080',
  'https://picsum.photos/400/200',
  'https://picsum.photos/300/400',
  'https://picsum.photos/200/300',
];

const Offset emotionPosition = Offset(-0.2, 0.2);

class DiaryDetailScreen extends StatelessWidget {
  final DateTime date;

  const DiaryDetailScreen({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DateFormat.yMMMMd().format(date),
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size16,
        ),
        child: ListView(
          children: [
            Gaps.v16,
            _buildDiarySection(context, height: 300.0),
            _buildImageSection(height: 100.0, imageUrls: imageUrls),
            Gaps.v4,
            _buildAnalysisSection(context, height: 180.0),
            // _buildEmotionSection(),
            // Gaps.v16,
            // _buildWordCloudSection(),
            // Gaps.v16,
            // _buildShareSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDiarySection(
    BuildContext context, {
    required double height,
  }) {
    return Container(
      height: height,
      padding: const EdgeInsets.only(
        left: Sizes.size16,
        right: Sizes.size16,
        top: Sizes.size18,
        bottom: Sizes.size12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2.0,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return TextPageView(
            text: DiarySampleText,
            textStyle: const TextStyle(
              fontSize: Sizes.size16,
              height: 1.3,
            ),
            constraints: constraints,
          );
        },
      ),
    );
  }

  Widget _buildImageSection({
    required double height,
    required List<String> imageUrls,
  }) {
    return SizedBox(
      height: height,
      child: ImageSlider(
        imageUrls: imageUrls,
      ),
    );
  }

  Widget _buildAnalysisSection(
    BuildContext context, {
    required double height,
  }) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size12,
        vertical: Sizes.size12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2.0,
        ),
      ),
      child: InsightPages(
        pages: [
          const MoodAnalysisCard(
            moodOffset: Offset(-0.5, -0.2),
          ),
          Container(
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
