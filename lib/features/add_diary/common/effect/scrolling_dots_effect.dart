import 'package:flutter/material.dart';
import 'package:moodiary/constants/colors.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomScrollingDotsEffect {
  static const IndicatorEffect effect = ScrollingDotsEffect(
    activeDotColor: customPrimarySwatch,
    dotColor: Colors.grey,
    dotHeight: Sizes.size8,
    dotWidth: Sizes.size8,
    spacing: Sizes.size8,
  );
}
