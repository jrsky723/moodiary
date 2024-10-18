import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodiary/constants/colors.dart';
import 'package:moodiary/constants/sizes.dart';

class AuthButton extends StatefulWidget {
  final FaIcon icon;

  final Function()? onTap;
  const AuthButton({
    super.key,
    required this.icon,
    this.onTap,
  });

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() {
        _isPressed = true;
      }),
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        widget.onTap!();
      },
      onTapCancel: () => setState(() {
        _isPressed = false;
      }),
      child: Transform.scale(
        scale: _isPressed ? 0.90 : 0.95,
        alignment: Alignment.center,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: _isPressed
                ? customPrimarySwatch.shade600
                : customPrimarySwatch.shade300.withOpacity(0.5),
            borderRadius: BorderRadius.circular(
              Sizes.size5,
            ),
            boxShadow: _isPressed
                ? []
                : [
                    BoxShadow(
                      blurRadius: Sizes.size2,
                      color: Colors.grey.shade200,
                    ),
                  ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(Sizes.size20),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: widget.icon,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
