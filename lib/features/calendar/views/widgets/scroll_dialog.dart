import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/utils/build_utils.dart';

enum ScrollDialogMode { year, month }

class ScrollDialog extends StatefulWidget {
  final ScrollDialogMode mode;
  final int startNumber, endNumber, initialItemIndex;
  final void Function(int) onSelectedItemChanged;

  const ScrollDialog({
    super.key,
    required this.startNumber,
    required this.endNumber,
    required this.initialItemIndex,
    required this.mode,
    required this.onSelectedItemChanged,
  });

  @override
  State<ScrollDialog> createState() => _ScrollDialogState();
}

class _ScrollDialogState extends State<ScrollDialog> {
  late FixedExtentScrollController _controller;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _controller =
        FixedExtentScrollController(initialItem: widget.initialItemIndex);
    _selectedIndex = widget.initialItemIndex;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    double itemHeight = Sizes.size48;
    int visibleItems = 3;
    DateTime now = DateTime.now();
    return Expanded(
      child: SizedBox(
        height: itemHeight * visibleItems,
        child: ListWheelScrollView.useDelegate(
          controller: _controller,
          onSelectedItemChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
            widget.onSelectedItemChanged(widget.startNumber + index);
          },
          physics: const FixedExtentScrollPhysics(),
          itemExtent: itemHeight,
          diameterRatio: 2.0,
          perspective: 0.005,
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: widget.endNumber - widget.startNumber + 1,
            builder: (context, index) {
              return IntrinsicWidth(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: index == _selectedIndex
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                      ),
                    ),
                  ),
                  child: Text(
                    // '${widget.startNumber + index}${widget.itemText}',
                    widget.mode == ScrollDialogMode.year
                        ? DateFormat.y().format(
                            DateTime(widget.startNumber + index, 1, 1),
                          ) // 연도
                        : DateFormat.MMM().format(
                            DateTime(now.year, widget.startNumber + index, 1),
                          ), // 월
                    style: TextStyle(
                      fontSize: 16,
                      color: index == _selectedIndex
                          ? (isDark ? Colors.white : Colors.black)
                          : (isDark
                              ? Colors.grey.shade600
                              : Colors.grey.shade500),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
