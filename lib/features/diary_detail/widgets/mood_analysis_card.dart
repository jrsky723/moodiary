import 'package:flutter/material.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/diary_detail/painters/circumplex_model_painter.dart';

class MoodAnalysisCard extends StatelessWidget {
  // 2(text):1(graph) 비율로 구성
  const MoodAnalysisCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '감정 분석',
                style: TextStyle(
                  fontSize: Sizes.size18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.v8,
              Text(
                '오늘의 감정을 분석한 결과입니다.',
                style: TextStyle(
                  fontSize: Sizes.size14,
                ),
              ),
              Gaps.v8,
              Row(
                children: [
                  Text(
                    '기쁨',
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.h8,
                  Text(
                    '60%',
                    style: TextStyle(
                      fontSize: Sizes.size16,
                    ),
                  ),
                ],
              ),
              Gaps.v8,
              Row(
                children: [
                  Text(
                    '슬픔',
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.h8,
                  Text(
                    '40%',
                    style: TextStyle(
                      fontSize: Sizes.size16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: CustomPaint(
              size: const Size(100, 100),
              painter: CircumplexModelPainter(
                x: 0.2,
                y: 0.8,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
