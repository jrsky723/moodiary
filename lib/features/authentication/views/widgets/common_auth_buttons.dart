import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/authentication/views/widgets/auth_button.dart';

class AuthButtons extends ConsumerWidget {
  final VoidCallback onLocalTap;
  final VoidCallback onGoogleTap;

  const AuthButtons({
    super.key,
    required this.onLocalTap,
    required this.onGoogleTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AuthButton(
          icon: const FaIcon(
            FontAwesomeIcons.user,
            size: Sizes.size30,
          ),
          onTap: onLocalTap,
        ),
        Gaps.h14,
        AuthButton(
          icon: const FaIcon(
            FontAwesomeIcons.google,
            size: Sizes.size30,
          ),
          onTap: onGoogleTap,
        ),
        Gaps.h14,
        const AuthButton(
          icon: FaIcon(
            FontAwesomeIcons.apple,
            size: Sizes.size30,
          ),
        ),
      ],
    );
  }
}
