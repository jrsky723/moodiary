import 'package:flutter/material.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/diary_detail/widgets/mood_analysis_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InsightPages extends StatefulWidget {
  const InsightPages({super.key});

  @override
  State<InsightPages> createState() => _InsightPagerState();
}

class _InsightPagerState extends State<InsightPages> {
  final PageController _pageController = PageController(viewportFraction: 1.1);

  final List<Widget> _pages = [
    const MoodAnalysisCard(),
    Container(
      // todo: word cloud
      color: Colors.red,
    ),
  ];

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
                  _pages.length,
                  (index) {
                    return FractionallySizedBox(
                      widthFactor: 1 / _pageController.viewportFraction,
                      child: _pages[index],
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
                    count: _pages.length,
                    effect: WormEffect(
                      dotWidth: Sizes.size8,
                      dotHeight: Sizes.size8,
                      activeDotColor: Theme.of(context).primaryColor,
                    ),
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
