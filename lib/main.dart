import 'package:flutter/material.dart';

void main() {
  runApp(const Moodiary());
}

class Moodiary extends StatelessWidget {
  const Moodiary({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Moodiary',
      home: Scaffold(
        body: Center(
          child: Text("Moodiary"),
        ),
      ),
    );
  }
}
