import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodiary/constants/colors.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/generated/l10n.dart';
import 'package:moodiary/utils/build_utils.dart';

Future<DateTime?> showDateSelectionSheet({
  required BuildContext context,
  required ScrollController scrollController,
  required bool isMonthly,
  required double itemExtent,
  required int selectedIndex,
  required int itemCount,
  required DateTime now,
}) {
  return showModalBottomSheet<DateTime>(
    clipBehavior: Clip.antiAlias,
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 300,
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor:
                  isDarkMode(context) ? Colors.grey.shade900 : Colors.white,
              surfaceTintColor: Colors.transparent,
              leading: const SizedBox(),
              actions: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
              title: Text(
                isMonthly
                    ? S.of(context).montlyDateSelectTitle
                    : S.of(context).yearlyDateSelectTitle,
                style: const TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
              pinned: true,
            ),
            SliverFixedExtentList(
              itemExtent: itemExtent,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final int year = isMonthly
                      ? index < now.month
                          ? now.year
                          : now.year - (index - now.month) ~/ 12 - 1
                      : now.year - index;
                  final int month =
                      isMonthly ? (now.month - index - 1) % 12 + 1 : 1;

                  return ListTile(
                    tileColor: isDarkMode(context)
                        ? Colors.grey.shade900
                        : Colors.white,
                    selected: index == selectedIndex,
                    selectedTileColor: isDarkMode(context)
                        ? customPrimarySwatch.shade900.withOpacity(1.0)
                        : Theme.of(context).primaryColor.withOpacity(0.1),
                    title: Text(
                      isMonthly
                          ? DateFormat.yMMMM().format(DateTime(year, month))
                          : year.toString(),
                      style: const TextStyle(fontSize: Sizes.size16),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(DateTime(year, month));
                    },
                  );
                },
                childCount: itemCount,
              ),
            ),
          ],
        ),
      );
    },
  );
}
