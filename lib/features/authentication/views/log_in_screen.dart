import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/authentication/view_models/social_auth_view_model.dart';
import 'package:moodiary/features/authentication/views/login_form_screen.dart';
import 'package:moodiary/features/authentication/views/widgets/auth_title.dart';
import 'package:moodiary/features/authentication/views/widgets/common_auth_buttons.dart';
import 'package:moodiary/generated/l10n.dart';

class LogInScreen extends ConsumerWidget {
  static const String routeName = 'login';
  static const String routeUrl = '/login';

  final String imagePath = 'assets/images/main.png';

  const LogInScreen({super.key});

  void _onSignUpTap(BuildContext context) {
    context.pop();
  }

  void _onLocalLoginTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginFormScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: Sizes.size80,
              bottom: Sizes.size20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AuthTitle(
                  title: 'MOODIARY',
                  description: S.of(context).appDiscription,
                ),
                Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: S.of(context).doYouHaveAccount,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.size14,
                            ),
                          ),
                          TextSpan(
                            text: S.of(context).gotoSignUp,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: Sizes.size14,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => _onSignUpTap(context),
                          ),
                        ],
                      ),
                    ),
                    Gaps.v32,
                    AuthButtons(
                      onLocalTap: () => _onLocalLoginTap(context),
                      onGoogleTap: () => ref
                          .read(socialAuthProvider.notifier)
                          .googleSignIn(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Opacity(
              opacity: 0.3,
              child: SizedBox(
                height: 200,
                width: 200,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
