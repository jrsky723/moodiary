import 'package:flutter/material.dart';

import 'package:moodiary/common/widgets/image_network.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/calendar/models/calendar_entry.dart';
import 'package:moodiary/utils/build_utils.dart';

class CalendarEntryWidget extends StatelessWidget {
  final bool isSelected;
  final bool isToday;
  final CalendarEntry entry;
  const CalendarEntryWidget({
    super.key,
    required this.entry,
    required this.isSelected,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
            ),
            shape: BoxShape.circle,
          ),
          child: Container(
            width: Sizes.size40,
            height: Sizes.size40,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: entry.hasDiary
                ? ImageNetwork(
                    imageUrl: entry.thumbnailUrl,
                  )
                : Image.asset(
                    'assets/images/moody.png',
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Gaps.v4,
        Container(
          width: Sizes.size32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color:
                isToday ? Theme.of(context).primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(Sizes.size8),
          ),
          child: Text(
            entry.date.day.toString(),
            style: TextStyle(
              fontSize: Sizes.size11,
              fontWeight: FontWeight.w600,
              color: isToday
                  ? Colors.white
                  : isSelected
                      ? Theme.of(context).primaryColor
                      : isDarkMode(context)
                          ? Colors.grey.shade400
                          : Colors.grey.shade700,
            ),
          ),
        ),
      ],
    );
  }
}
