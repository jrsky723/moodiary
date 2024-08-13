import 'package:flutter/material.dart';
import 'package:moodiary/features/add_diary/common/effect/scrolling_dots_effect.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InsightPages extends StatefulWidget {
  final List<Widget> pages;

  const InsightPages({super.key, required this.pages});

  @override
  State<InsightPages> createState() => _InsightPagerState();
}

class _InsightPagerState extends State<InsightPages> {
  final PageController _pageController = PageController(viewportFraction: 1.1);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            SizedBox(
              height: constraints.maxHeight * 0.9,
              child: PageView(
                controller: _pageController,
                children: List.generate(
                  widget.pages.length,
                  (index) {
                    return FractionallySizedBox(
                      widthFactor: 1 / _pageController.viewportFraction,
                      child: widget.pages[index],
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Opacity(
                  opacity: 0.5,
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: widget.pages.length,
                    effect: CustomScrollingDotsEffect.effect,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
