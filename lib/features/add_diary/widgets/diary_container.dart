import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        color: Colors.grey.shade100,
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: widget.crossAxisAlignment,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 5,
                right: 5,
                top: 5,
                bottom: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.text,
                  ),
                  IconButton(
                    onPressed: onBlankButton,
                    icon: const FaIcon(
                      FontAwesomeIcons.chevronDown,
                      size: 12,
                    ),
                  ),
                ],
              ),
            ),
            isShow ? widget.child : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
