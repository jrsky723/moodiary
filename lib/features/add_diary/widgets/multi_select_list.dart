import 'package:flutter/material.dart';
import 'package:moodiary/common/widgets/circle_avatar.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';

class MultiSelectList extends StatefulWidget {
  final List<String> items;
  final int crossAxisCount;
  const MultiSelectList({
    super.key,
    required this.items,
    required this.crossAxisCount,
  });

  @override
  State<MultiSelectList> createState() => MultiSelectListState();
}

class MultiSelectListState extends State<MultiSelectList> {
  Set<int> selectedIndexes = <int>{}; // 선택된 인덱스들을 저장하는 Set

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(
        Sizes.size10,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        childAspectRatio: 11 / 10,
      ),
      itemCount: widget.items.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              if (selectedIndexes.contains(index)) {
                selectedIndexes.remove(index); // 이미 선택된 경우 선택 해제
              } else {
                selectedIndexes.add(index); // 선택되지 않은 경우 선택
              }
            });
          },
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.all(Sizes.size2), // Space for the border

                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selectedIndexes.contains(index)
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    width: Sizes.size3,
                  ),
                ),
                child: const SCircleAvatar(),
              ),
              Gaps.v2,
              Text(
                widget.items[index],
                style: const TextStyle(
                  fontSize: Sizes.size12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
