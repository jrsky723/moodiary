import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/authentication/view_models/social_auth_view_model.dart';
import 'package:moodiary/features/authentication/views/log_in_screen.dart';
import 'package:moodiary/features/authentication/views/username_screen.dart';
import 'package:moodiary/features/authentication/views/widgets/auth_title.dart';
import 'package:moodiary/features/authentication/views/widgets/common_auth_buttons.dart';
import 'package:moodiary/generated/l10n.dart';

class SignUpScreen extends ConsumerWidget {
  static const String routeName = 'signup';
  static const String routeUrl = '/signup';

  const SignUpScreen({super.key});

  final String imagePath = 'assets/images/signup_title_img.png';

  void _onLoginTap(BuildContext context) {
    context.pushNamed(LogInScreen.routeName);
  }

  void _onEmailTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
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
                            text: S.of(context).doYouHaveAnAccountAlready,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.size14,
                            ),
                          ),
                          TextSpan(
                            text: S.of(context).gotoLogin,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: Sizes.size14,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => _onLoginTap(context),
                          ),
                        ],
                      ),
                    ),
                    Gaps.v32,
                    AuthButtons(
                      onLocalTap: () => _onEmailTap(context), // 회원가입 로직 추가
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
