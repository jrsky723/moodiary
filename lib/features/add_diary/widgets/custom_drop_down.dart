import 'package:flutter/material.dart';
import 'package:moodiary/constants/sizes.dart';

class ResizableDropdownButton extends StatefulWidget {
  final bool isDarkMode;
  final List<String> items;
  final String selectedValue;
  final String? title;
  final void Function(String) onChanged;
  const ResizableDropdownButton({
    super.key,
    required this.items,
    this.title,
    required this.selectedValue,
    required this.onChanged,
    required this.isDarkMode,
  });

  @override
  State<ResizableDropdownButton> createState() =>
      _ResizableDropdownButtonState();
}

class _ResizableDropdownButtonState extends State<ResizableDropdownButton> {
  String? _selectedValue;
  late final List<String> _dropdownItems;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
    _dropdownItems = widget.items;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizes.size60,
      height: Sizes.size52,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          alignment: Alignment.center,
          iconSize: Sizes.size20,
          value: _selectedValue,
          onChanged: (String? newValue) {
            setState(() {
              _selectedValue = newValue;
              widget.onChanged(newValue!);
            });
          },
          items: _dropdownItems.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(widget.title != null ? '$item ${widget.title}' : item,
                  style: TextStyle(
                    color:
                        widget.isDarkMode ? Colors.grey.shade500 : Colors.black,
                  )),
            );
          }).toList(),
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          icon: const Icon(Icons.arrow_drop_down),
          menuMaxHeight: Sizes.size80 + Sizes.size80 + Sizes.size40,
        ),
      ),
    );
  }
}
