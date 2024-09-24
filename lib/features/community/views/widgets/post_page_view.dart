import 'package:flutter/material.dart';
import 'package:moodiary/common/widgets/effect/scrolling_dots_effect.dart';
import 'package:moodiary/common/widgets/image_network.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostPageView extends StatefulWidget {
  final List<String> imageUrls;

  const PostPageView({
    super.key,
    required this.imageUrls,
  });

  @override
  State<PostPageView> createState() => _PostPageViewState();
}

class _PostPageViewState extends State<PostPageView> {
  final PageController _pageController = PageController();

  Widget _buildPostFrame({
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Sizes.size16,
        right: Sizes.size16,
        bottom: Sizes.size16,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(
              color: Colors.white.withOpacity(0.8),
              width: Sizes.size16,
            ),
          ),
          borderRadius: BorderRadius.circular(Sizes.size4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: Sizes.size5,
              offset: const Offset(0, Sizes.size8),
            ),
          ],
        ),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: _pageController,
          children: [
            for (String imageUrl in widget.imageUrls)
              _buildPostFrame(
                child: ImageNetwork(imageUrl: imageUrl),
              ),
          ],
        ),
        if (widget.imageUrls.length > 1)
          Align(
            alignment: const Alignment(0, 1.03),
            child: Opacity(
              opacity: 0.6,
              child: SmoothPageIndicator(
                controller: _pageController,
                count: widget.imageUrls.length,
                effect: CustomScrollingDotsEffect.effect,
              ),
            ),
          ),
      ],
    );
  }
}
