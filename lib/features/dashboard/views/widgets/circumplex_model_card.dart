import 'package:flutter/material.dart';
import 'package:moodiary/constants/colors.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/diary/views/painters/circumplex_model_painter.dart';
import 'package:moodiary/features/diary/views/painters/linear_indicator_painter.dart';
import 'package:moodiary/generated/l10n.dart';
import 'package:moodiary/utils/color_utils.dart';

class CircumplexModelCard extends StatelessWidget {
  final List<Offset> moodOffsets;
  final Text titleText;
  final Text subtitleText;

  const CircumplexModelCard({
    super.key,
    required this.moodOffsets,
    this.titleText = const Text(''),
    this.subtitleText = const Text(''),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              titleText,
              Gaps.v8,
              subtitleText,
              Gaps.v24,
              CustomPaint(
                size: const Size(double.infinity, 20.0),
                painter: LinearIndicatorPainter(
                  showAverage: true,
                  values: [for (final offset in moodOffsets) offset.dx],
                  leftColor: CMColors.unpleasant,
                  rightColor: CMColors.pleasant,
                  middleColor: Colors.grey,
                  indicatorRadius: Sizes.size3,
                  label: TextSpan(
                    text:
                        '${S.of(context).positive} - ${S.of(context).negative}: ${(meanX * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: Sizes.size14,
                      color: meanXColor,
                    ),
                  ),
                ),
              ),
              Gaps.v20,
              CustomPaint(
                size: const Size(double.infinity, 20.0),
                painter: LinearIndicatorPainter(
                  showAverage: true,
                  values: [for (final offset in moodOffsets) offset.dy],
                  leftColor: CMColors.deactivation,
                  rightColor: CMColors.activation,
                  middleColor: Colors.grey,
                  indicatorRadius: Sizes.size3,
                  label: TextSpan(
                    text:
                        '${S.of(context).active} - ${S.of(context).passive}: ${(meanY * 100).toInt()}%',
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
              showAverage: true,
            ),
          ),
        ),
      ],
    );
  }
}
