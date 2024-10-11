import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/authentication/view_models/social_auth_view_model.dart';
import 'package:moodiary/features/authentication/views/login_form_screen.dart';
import 'package:moodiary/features/authentication/views/username_screen.dart';
import 'package:moodiary/features/authentication/views/widgets/auth_button.dart';

class LogInScreen extends ConsumerWidget {
  static const String routeName = 'login';
  static const String routeUrl = '/login';

  // 임시 image asset URL
  final String imagePath = 'assets/images/login_title_img.png';

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
                Column(
                  children: [
                    Text(
                      'MOODIARY',
                      style: TextStyle(
                        fontSize: Sizes.size64,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const Text(
                      '감정 분석 일기앱',
                      style: TextStyle(
                        fontSize: Sizes.size20,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: '이미 계정이 없으신가요?  ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.size14,
                            ),
                          ),
                          TextSpan(
                            text: '회원가입하기',
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
                    AuthButton(
                      text: "login with email",
                      icon: const FaIcon(
                        FontAwesomeIcons.user,
                      ),
                      onTap: () => _onLocalLoginTap(context),
                    ),
                    Gaps.v14,
                    AuthButton(
                      text: "Google",
                      icon: const FaIcon(
                        FontAwesomeIcons.google,
                      ),
                      onTap: () => ref
                          .read(socialAuthProvider.notifier)
                          .googleSignIn(context),
                    ),
                    Gaps.v14,
                    const AuthButton(
                      text: "Apple",
                      icon: FaIcon(
                        FontAwesomeIcons.apple,
                      ),
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
