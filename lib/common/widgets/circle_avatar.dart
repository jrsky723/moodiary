import 'package:flutter/material.dart';

class SCircleAvatar extends StatelessWidget {
  const SCircleAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.grey.shade300,
      radius: 20,
    );
  }
}
