import 'package:flutter/material.dart';
import 'package:moodiary/constants/sizes.dart';

class ImageSlider extends StatefulWidget {
  final List<String> imageUrls;

  const ImageSlider({super.key, required this.imageUrls});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  late final PageController _pageController;
  final int _visibleImageCount = 5;
  late final int _initialPage, _minPageIndex, _maxPageIndex;

  void _onTap(int index) {
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
              child: Image.network(
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.error,
                    color: Colors.grey,
                  );
                },
                widget.imageUrls[index],
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        );
      },
    );
  }

  void _initPageValues() {
    final imageCount = widget.imageUrls.length;
    if (imageCount < _visibleImageCount) {
      _initialPage = imageCount ~/ 2;
      _minPageIndex = imageCount.isEven ? _initialPage - 1 : _initialPage;
      _maxPageIndex = imageCount - 1 - _minPageIndex;
    } else {
      _initialPage = _visibleImageCount ~/ 2;
      _minPageIndex = _initialPage;
      _maxPageIndex = imageCount - 1 - _minPageIndex;
    }
  }

  @override
  void initState() {
    _initPageValues();
    _pageController = PageController(
      viewportFraction: 1 / _visibleImageCount,
      initialPage: _initialPage,
    );
    super.initState();
  }

  void _onPageChanged(int index) {
    if (index < _minPageIndex) {
      _pageController.animateToPage(
        _minPageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else if (index > _maxPageIndex) {
      _pageController.animateToPage(
        _maxPageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.imageUrls.length,
      scrollDirection: Axis.horizontal,
      onPageChanged: _onPageChanged,
      itemBuilder: (context, index) {
        final imageWidth = width / _visibleImageCount;
        return Center(
          child: GestureDetector(
            onTap: () => _onTap(index),
            child: Transform.scale(
              scale: 0.9,
              child: Container(
                height: imageWidth,
                width: imageWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    Sizes.size5,
                  ),
                  border: Border.all(
                    color: Colors.white,
                    width: Sizes.size3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: Sizes.size5,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Image.network(
                  widget.imageUrls[index],
                  fit: BoxFit.cover,
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded) {
                      return child;
                    }
                    return AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: frame == null ? 0 : 1,
                      child: child,
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.error,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
