import 'package:flutter/material.dart';

class AuthMainTitle extends StatelessWidget {
  final String imageUrl;
  const AuthMainTitle({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Sign Up'),
        Image.asset(
          imageUrl,
          fit: BoxFit.fitWidth,
        )
      ],
    );
  }
}
