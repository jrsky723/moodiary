import 'package:flutter/material.dart';
import 'package:moodiary/constants/sizes.dart';

class AuthTitle extends StatelessWidget {
  final String title;
  final String description;

  const AuthTitle({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: Sizes.size64,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Text(
          description,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
