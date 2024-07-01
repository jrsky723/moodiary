import 'package:flutter/material.dart';

class AddDiaryAvatar extends StatelessWidget {
  const AddDiaryAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.grey.shade300,
      radius: 20,
    );
  }
}
