import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodiary/utils/theme_utils.dart';

class DiaryContainer extends StatefulWidget {
  final Widget child;
  final String text;
  final CrossAxisAlignment crossAxisAlignment;
  const DiaryContainer({
    super.key,
    required this.child,
    this.text = "Empty",
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  State<DiaryContainer> createState() => _DiaryContainerState();
}

class _DiaryContainerState extends State<DiaryContainer> {
  bool isShow = true;

  void onBlankButton() {
    setState(() {
      isShow = !isShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        // Add this
        color: isDarkMode(context) ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 0.2,
            offset: const Offset(0, 0),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8,
          right: 8,
          bottom: 8,
        ),
        child: Column(
          crossAxisAlignment: widget.crossAxisAlignment,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.text,
                  ),
                  IconButton(
                    onPressed: onBlankButton,
                    icon: FaIcon(
                      FontAwesomeIcons.chevronDown,
                      size: 12,
                      color: isDarkMode(context)
                          ? Colors.grey.shade500
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isShow,
              maintainState: true,
              maintainAnimation: true,
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}
