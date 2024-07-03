import 'package:flutter/material.dart';
import 'package:moodiary/constants/sizes.dart';

class CustomDropdown extends StatefulWidget {
  final int selectedNum;
  final int itemsCount;
  final ValueChanged<int> onChanged;
  final String title;
  const CustomDropdown({
    super.key,
    required this.selectedNum,
    required this.itemsCount,
    required this.onChanged,
    required this.title,
  });
  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;
  late final List<String> dropdownItems;

  double popUpSize = 200;
  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedNum.toString();
    dropdownItems =
        List.generate(widget.itemsCount, (index) => (index).toString());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showCustomDropdown(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.size8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selectedValue != null
                  ? "$selectedValue ${widget.title}"
                  : "${widget.selectedNum} ${widget.title}",
              style: const TextStyle(
                fontSize: Sizes.size14 + Sizes.size1,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomDropdown(BuildContext context) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    final String? selected = await showMenu<String>(
      context: context,
      position: position,
      items: dropdownItems
          .map((String value) => PopupMenuItem<String>(
                height: Sizes.size30,
                value: value,
                child: SizedBox(
                  child: Text(value),
                ),
              ))
          .toList(),
      constraints: BoxConstraints(
        maxHeight: popUpSize, // Limit the height to 200
      ),
    );

    setState(() {
      selectedValue = selected;
      if (selected != null) {
        widget.onChanged(int.parse(selected));
      }
    });
  }
}
