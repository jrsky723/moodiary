import 'package:flutter/material.dart';
import 'package:moodiary/generated/l10n.dart';

class PostContent extends StatefulWidget {
  final String username;
  final String content;

  const PostContent({
    super.key,
    required this.username,
    required this.content,
  });

  @override
  State<PostContent> createState() => _PostContentState();
}

class _PostContentState extends State<PostContent> {
  bool _isExpanded = false;
  static const int overflowLimit = 101;

  double _calculateLineHeight(TextStyle style, BuildContext context) {
    final span = TextSpan(text: "Sample Text", style: style);
    final painter = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
    );
    painter.layout(maxWidth: MediaQuery.of(context).size.width);
    return painter.size.height; // 한 줄의 높이를 반환
  }

  @override
  Widget build(BuildContext context) {
    final usernameStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.bold,
        );
    final contentStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
          height: 1.8,
        );

    String displayContent = widget.content;
    if (!_isExpanded && widget.content.length > overflowLimit) {
      displayContent = widget.content.substring(0, overflowLimit);
    }

    // 텍스트 높이 계산
    final lineHeight = _calculateLineHeight(contentStyle, context);

    // TextPainter로 줄 수 계산
    final textSpan = TextSpan(
      text: '${widget.username} $displayContent',
      style: contentStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      maxLines: _isExpanded ? null : 3, // 더보기 누르면 제한이 없음
    );

    // 레이아웃 정보를 얻기 위해 화면 너비 설정
    textPainter.layout(maxWidth: MediaQuery.of(context).size.width);

    // 실제 줄 수 계산
    final lineCount = textPainter.computeLineMetrics().length;

    return Stack(
      children: [
        // 밑줄 그리기
        Column(
          children: List.generate(
            lineCount,
            (index) => Container(
              margin: EdgeInsets.only(
                top: lineHeight - 1, // 텍스트 높이에 따라 동적으로 설정, 밑줄의 두께만큼 빼줌
              ),
              height: 1, // 밑줄의 두께
              color: Colors.grey.withOpacity(0.7),
            ),
          ),
        ),
        // 텍스트 그리기
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.username,
                style: usernameStyle,
              ),
              TextSpan(
                text: ' $displayContent',
                style: contentStyle,
              ),
              if (!_isExpanded && widget.content.length > overflowLimit) ...[
                TextSpan(
                  text: ' ... ',
                  style: contentStyle,
                ),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isExpanded = true;
                      });
                    },
                    child: Text(
                      S.of(context).seeMore,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
