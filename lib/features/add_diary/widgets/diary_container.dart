import 'package:flutter/material.dart';

class DiaryContainer extends StatelessWidget {
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
          crossAxisAlignment: crossAxisAlignment,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 5,
                right: 5,
                top: 5,
                bottom: 15,
              ),
              child: Text(
                text,
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
