import 'package:flutter/material.dart';
import 'package:moodiary/common/widgets/circle_avatar.dart';
import 'package:moodiary/constants/sizes.dart';

class DailyList extends StatefulWidget {
  const DailyList({super.key});

  @override
  _DailyListState createState() => _DailyListState();
}

class _DailyListState extends State<DailyList> {
  int selectedIndex = -1; // Initial selection index, -1 means none selected

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index; // Update selected index
            });
          },
          child: Container(
            padding: const EdgeInsets.all(Sizes.size2), // Space for the border
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selectedIndex == index
                    ? Theme.of(context).primaryColor
                    : Colors.transparent, // Conditional border color
                width: Sizes.size3,
              ),
            ),
            child: const SCircleAvatar(),
          ),
        );
      }),
    );
  }
}
