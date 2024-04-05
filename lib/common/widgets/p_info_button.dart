import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodiary/constants/sizes.dart';

class pInfoButton extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color? color;
  const pInfoButton({
    super.key,
    required this.icon,
    this.size = Sizes.size14,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size10,
      ),
      child: GestureDetector(
        onTap: () {},
        child: FaIcon(
          icon,
          size: size,
          color: color,
        ),
      ),
    );
  }
}

// Vertical Divider 작동 안됨 있긴한데 안보임
// gestureDetector 를 이용해서 클릭하면 reverse되어서 뒤에는 글이 앞에는 이모지 보이게 설정 
//  + text overflow되면 아이콘 만들어서 펼치기 기능 가능하도록 설정(optional)