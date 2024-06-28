import 'package:flutter/material.dart';
import 'package:moodiary/constants/sizes.dart';

class TextPageView extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final BoxConstraints constraints;

  const TextPageView({
    super.key,
    required this.text,
    required this.textStyle,
    required this.constraints,
  });

  @override
  State<TextPageView> createState() => _TextPageViewState();
}

class _TextPageViewState extends State<TextPageView> {
  late List<String> _pages;
  final pageController = PageController(viewportFraction: 1.1);

  @override
  void initState() {
    super.initState();
    _pages = _splitTextToPages(
      widget.text,
      widget.textStyle,
      widget.constraints,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  List<String> _splitTextToPages(
      String text, TextStyle style, BoxConstraints constraints) {
    List<String> pages = [];
    TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    double lineHeight =
        style.height ?? 1.0; // TextStyle에 height가 설정되어 있지 않으면 기본값 1.0 사용
    double lineHeightPx = style.fontSize! * lineHeight;

    List<String> words = text.split(' ');
    int start = 0;
    while (start < words.length) {
      int end = start;
      while (end < words.length) {
        textPainter.text = TextSpan(
          text: words.sublist(start, end + 1).join(' '),
          style: style,
        );
        textPainter.layout(maxWidth: constraints.maxWidth);
        if (textPainter.height + lineHeightPx > constraints.maxHeight) {
          break;
        }
        end++;
      }
      if (end == start) {
        break; // Avoid infinite loop if a single word can't fit in the page.
      }
      // 마지막 페이지 제외, 나머지 페이지에는 마지막 단어를 포함하지 않음
      // 마지막 페이지일 경우, 마지막 단어를 포함
      if (end == words.length) {
        pages.add(words.sublist(start, end).join(' '));
        start = end;
      } else {
        pages.add(words.sublist(start, end - 1).join(' '));
        start = end - 1;
      }
    }
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: _pages.length,
      itemBuilder: (context, index) {
        return FractionallySizedBox(
          widthFactor: 1 / pageController.viewportFraction,
          child: Stack(
            children: [
              Text(
                _pages[index],
                style: widget.textStyle,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  '${index + 1}/${_pages.length}',
                  style: TextStyle(
                    fontSize: Sizes.size12,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
