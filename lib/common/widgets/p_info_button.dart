import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodiary/constants/sizes.dart';

class InfoButton extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color? color;
  final Function()? onTap;

  const InfoButton({
    super.key,
    required this.icon,
    this.size = Sizes.size14,
    this.color = Colors.grey,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: FaIcon(
        icon,
        size: size,
        color: color,
      ),
      onPressed: onTap,
    );
  }
}
