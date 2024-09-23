import 'package:flutter/material.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/utils/build_utils.dart';

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

  @override
  Widget build(BuildContext context) {
    final darkmode = isDarkMode(context);
    final usernameStyle = TextStyle(
      color: darkmode ? Colors.white : Colors.black,
      fontWeight: FontWeight.bold,
    );
    final contentStyle = TextStyle(
      height: 1.8,
      color: darkmode ? Colors.white : Colors.black,
    );

    String displayContent = widget.content;
    if (!_isExpanded && widget.content.length > overflowLimit) {
      displayContent = widget.content.substring(0, overflowLimit);
    }

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
    final lineCount = textPainter.computeLineMetrics().length + 1;

    return Stack(
      children: [
        // 밑줄 그리기
        Column(
          children: List.generate(
            lineCount,
            (index) => Container(
              margin: const EdgeInsets.only(
                top: Sizes.size24,
              ), // 텍스트와 밑줄 사이 간격
              height: 1, // 밑줄의 두께
              color: Colors.grey, // 밑줄 색상
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
                  text: ' ...',
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
                      '더보기',
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
