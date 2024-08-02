import 'package:flutter/material.dart';
import 'package:moodiary/constants/colors.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/diary_detail/painters/circumplex_model_painter.dart';
import 'package:moodiary/features/diary_detail/painters/linear_indicator_painter.dart';
import 'package:moodiary/utils/color_utils.dart';

class CircumplexModelCard extends StatelessWidget {
  final List<Offset> moodOffsets;

  const CircumplexModelCard({
    super.key,
    required this.moodOffsets,
  });

  double getMeanX() {
    return moodOffsets.map((offset) => offset.dx).reduce((a, b) => a + b) /
        moodOffsets.length;
  }

  double getMeanY() {
    return moodOffsets.map((offset) => offset.dy).reduce((a, b) => a + b) /
        moodOffsets.length;
  }

  @override
  Widget build(BuildContext context) {
    final meanX = getMeanX();
    final meanY = getMeanY();
    final meanXColor = getIndicatorColor(
        value: meanX,
        leftColor: CMColors.unpleasant,
        rightColor: CMColors.pleasant,
        middleColor: Colors.grey);
    final meanYColor = getIndicatorColor(
        value: meanY,
        leftColor: CMColors.deactivation,
        rightColor: CMColors.activation,
        middleColor: Colors.grey);

    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Column(
            children: [
              const Text(
                'Circumplex Model',
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.v8,
              const Text(
                '감정 분석(28일)',
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.grey,
                ),
              ),
              Gaps.v8,
              CustomPaint(
                size: const Size(double.infinity, 40.0),
                painter: LinearIndicatorPainter(
                  values: [for (final offset in moodOffsets) offset.dx],
                  leftColor: CMColors.unpleasant,
                  rightColor: CMColors.pleasant,
                  middleColor: Colors.grey,
                  indicatorRadius: Sizes.size3,
                  label: TextSpan(
                    text: 'Positive-Negative: ${(meanX * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: Sizes.size14,
                      color: meanXColor,
                    ),
                  ),
                ),
              ),
              Gaps.v8,
              CustomPaint(
                size: const Size(double.infinity, 40.0),
                painter: LinearIndicatorPainter(
                  values: [for (final offset in moodOffsets) offset.dy],
                  leftColor: CMColors.deactivation,
                  rightColor: CMColors.activation,
                  middleColor: Colors.grey,
                  indicatorRadius: Sizes.size3,
                  label: TextSpan(
                    text: 'Active-Passive: ${(meanY * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: Sizes.size14,
                      color: meanYColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Gaps.h8,
        Flexible(
          flex: 1,
          child: CustomPaint(
            size: const Size(double.infinity, double.infinity),
            painter: CircumplexModelPainter(
              moodOffsets: moodOffsets,
            ),
          ),
        ),
      ],
    );
  }
}
