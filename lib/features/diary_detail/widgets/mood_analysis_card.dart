import 'package:flutter/material.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/diary_detail/painters/circumplex_model_painter.dart';
import 'package:moodiary/features/diary_detail/painters/linear_indicator_painter.dart';

class MoodAnalysisCard extends StatelessWidget {
  // 2(text):1(graph) 비율로 구성
  final Offset moodOffset;

  const MoodAnalysisCard({
    super.key,
    required this.moodOffset,
  });

  Color? _getIndicatorColor(
    double value, {
    Color? positiveColor,
    Color? negativeColor,
  }) {
    final color = Color.lerp(
      negativeColor,
      positiveColor,
      (value + 1) / 2,
    );
    // 얼마나 원점에 가까이에 있는지에 따라 회색을 섞어줌
    return Color.lerp(
      Colors.grey,
      color,
      (value).abs() * 1.5,
    );
  }

  void _onInfoButtonPressed(BuildContext context) {
    // circumplexModel의 정보 이미지를 보여준다
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SizedBox(
              width: double.infinity,
              child: Image.asset(
                'assets/images/circumplex_model_colors.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final indicatorColorX = _getIndicatorColor(
      moodOffset.dx,
      positiveColor: CMColors.pleasant,
      negativeColor: CMColors.unpleasant,
    );

    final indicatorColorY = _getIndicatorColor(
      moodOffset.dy,
      positiveColor: CMColors.activation,
      negativeColor: CMColors.deactivation,
    );

    return Row(
      children: [
        Flexible(
          flex: 2, // 2 비율을 가짐
          fit: FlexFit.tight,
          child: Padding(
            padding: const EdgeInsets.only(
              left: Sizes.size6,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '감정 분석',
                  style: TextStyle(
                    fontSize: Sizes.size18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v8,
                const Text(
                  '오늘의 감정을 분석한 결과입니다.',
                  style: TextStyle(
                    fontSize: Sizes.size14,
                  ),
                ),
                Gaps.v16,
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: Sizes.size18,
                      bottom: Sizes.size12,
                    ),
                    child: CustomPaint(
                      // positive-negative
                      size: const Size(double.infinity, double.infinity),
                      painter: LinearIndicatorPainter(
                        label: TextSpan(
                          text:
                              '${moodOffset.dx >= 0 ? '행복' : '불행'}: ${(moodOffset.dx * 100).toInt().abs()}%',
                          style: TextStyle(
                            fontSize: Sizes.size12,
                            color: indicatorColorX,
                          ),
                        ),
                        value: moodOffset.dx,
                        color: indicatorColorX,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: Sizes.size18,
                      bottom: Sizes.size12,
                    ),
                    child: CustomPaint(
                      // active-sleepy
                      size: const Size(double.infinity, double.infinity),
                      painter: LinearIndicatorPainter(
                        label: TextSpan(
                          text:
                              '${moodOffset.dy >= 0 ? '활발' : '졸림'}: ${(moodOffset.dy * 100).toInt().abs()}%',
                          style: TextStyle(
                            fontSize: Sizes.size12,
                            color: indicatorColorY,
                          ),
                        ),
                        value: moodOffset.dy,
                        color: indicatorColorY,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 1, // 1 비율을 가짐
          fit: FlexFit.tight,
          child: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                child: CustomPaint(
                  size: const Size(double.infinity, double.infinity),
                  painter: CircumplexModelPainter(moodOffset: moodOffset),
                ),
              ),
              // 확대 버튼
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: Sizes.size24,
                  height: Sizes.size24,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    color: Colors.white,
                    icon: const Icon(Icons.info_outline_rounded),
                    iconSize: Sizes.size20,
                    onPressed: () => _onInfoButtonPressed(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
