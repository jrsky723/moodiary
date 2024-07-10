// import 'package:flutter/material.dart';
// import 'package:moodiary/constants/sizes.dart';

// class CustomDropdown extends StatefulWidget {
//   final int selectedNum;
//   final int itemsCount;
//   final ValueChanged<int> onChanged;
//   final String title;
//   @override
//   const CustomDropdown({
//     super.key,
//     required this.selectedNum,
//     required this.itemsCount,
//     required this.onChanged,
//     required this.title,
//   });
//   @override
//   State<CustomDropdown> createState() => _CustomDropdownState();
// }

// class _CustomDropdownState extends State<CustomDropdown> {
//   String? selectedValue;
//   late final List<String> dropdownItems;
//   final GlobalKey _buttonKey = GlobalKey();

//   double popUpSize = 200;
//   @override
//   void initState() {
//     super.initState();
//     selectedValue = widget.selectedNum.toString();
//     dropdownItems =
//         List.generate(widget.itemsCount, (index) => (index).toString());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       key: _buttonKey,
//       onTap: () async {
//         final selected = await _showCustomDropdown(context);

//         if (selected != null) {
//           setState(() {
//             selectedValue = selected;
//             widget.onChanged(int.parse(selected));
//           });
//         }
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(
//           vertical: Sizes.size12,
//         ),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(Sizes.size8),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               selectedValue != null
//                   ? "$selectedValue ${widget.title}"
//                   : "${widget.selectedNum} ${widget.title}",
//               style: const TextStyle(
//                 fontSize: Sizes.size14 + Sizes.size1,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const Icon(
//               Icons.arrow_drop_down,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<String?> _showCustomDropdown(BuildContext context) async {
//     final RenderBox button = context.findRenderObject() as RenderBox;
//     final RenderBox overlay =
//         Overlay.of(context).context.findRenderObject() as RenderBox;

//     final RelativeRect position = RelativeRect.fromRect(
//       Rect.fromPoints(
//         button.localToGlobal(Offset.zero, ancestor: overlay),
//         button.localToGlobal(button.size.bottomRight(Offset.zero),
//             ancestor: overlay),
//       ),
//       Offset.zero & overlay.size,
//     );

//     return await showMenu<String>(
//       context: context,
//       position: position,
//       items: dropdownItems
//           .map((String value) => PopupMenuItem<String>(
//                 height: Sizes.size30,
//                 value: value,
//                 child: SizedBox(
//                   child: Text(value),
//                 ),
//               ))
//           .toList(),
//       constraints: BoxConstraints(
//         maxHeight: popUpSize, // Limit the height to 200
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ResizableDropdownButton extends StatefulWidget {
  const ResizableDropdownButton({super.key});

  @override
  _ResizableDropdownButtonState createState() =>
      _ResizableDropdownButtonState();
}

class _ResizableDropdownButtonState extends State<ResizableDropdownButton> {
  String? _selectedValue;
  final List<String> _dropdownItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10'
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150, // 원하는 너비로 조절
      height: 50, // 원하는 높이로 조절
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          value: _selectedValue,
          hint: const Text('Select an item'),
          onChanged: (String? newValue) {
            setState(() {
              _selectedValue = newValue;
            });
          },
          items: _dropdownItems.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            border: InputBorder.none,
          ),
          dropdownColor: Colors.white,
          icon: const Icon(Icons.arrow_drop_down),
          menuMaxHeight: 200,
        ),
      ),
    );
  }
}
