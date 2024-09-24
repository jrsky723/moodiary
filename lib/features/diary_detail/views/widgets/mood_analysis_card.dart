import 'package:flutter/material.dart';
import 'package:moodiary/constants/colors.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/diary_detail/painters/circumplex_model_painter.dart';
import 'package:moodiary/features/diary_detail/painters/linear_indicator_painter.dart';
import 'package:moodiary/features/diary_detail/widgets/info_image_button.dart';
import 'package:moodiary/generated/l10n.dart';
import 'package:moodiary/utils/color_utils.dart';

class MoodAnalysisCard extends StatelessWidget {
  // 2(text):1(graph) 비율로 구성
  final Offset moodOffset;

  const MoodAnalysisCard({
    super.key,
    required this.moodOffset,
  });

  @override
  Widget build(BuildContext context) {
    final indicatorColorX = getIndicatorColor(
      value: moodOffset.dx,
      leftColor: CMColors.unpleasant,
      rightColor: CMColors.pleasant,
      middleColor: Colors.grey,
    );
    final indicatorColorY = getIndicatorColor(
      value: moodOffset.dy,
      leftColor: CMColors.deactivation,
      rightColor: CMColors.activation,
      middleColor: Colors.grey,
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
                Text(
                  S.of(context).moodAnalysis,
                  style: const TextStyle(
                    fontSize: Sizes.size18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v8,
                Text(
                  S.of(context).moodAnalysisExplanation,
                  style: const TextStyle(
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
                              '${moodOffset.dx >= 0 ? S.of(context).happiness : S.of(context).unhappiness}: ${(moodOffset.dx * 100).toInt().abs()}%',
                          style: TextStyle(
                            fontSize: Sizes.size12,
                            color: indicatorColorX,
                          ),
                        ),
                        values: [moodOffset.dx],
                        leftColor: CMColors.unpleasant,
                        rightColor: CMColors.pleasant,
                        middleColor: Colors.grey,
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
                              '${moodOffset.dy >= 0 ? S.of(context).activeness : S.of(context).sleepiness}: ${(moodOffset.dy * 100).toInt().abs()}%',
                          style: TextStyle(
                            fontSize: Sizes.size12,
                            color: indicatorColorY,
                          ),
                        ),
                        values: [moodOffset.dy],
                        leftColor: CMColors.deactivation,
                        rightColor: CMColors.activation,
                        middleColor: Colors.grey,
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
                  painter: CircumplexModelPainter(moodOffsets: [moodOffset]),
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
                  child: const InfoImageButton(
                    isAsset: true,
                    imageUrl: 'assets/images/circumplex_model_colors.png',
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
