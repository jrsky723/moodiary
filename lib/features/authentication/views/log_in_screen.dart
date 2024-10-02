import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/features/authentication/views/login_form_screen.dart';
import 'package:moodiary/features/authentication/views/username_screen.dart';
import 'package:moodiary/features/authentication/views/widgets/auth_button.dart';

class LogInScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Text(
                'Moodiary',
                style: TextStyle(fontSize: 50),
              ),
              const Text('Log In'),
              Image.asset(
                imagePath,
                fit: BoxFit.fitWidth,
              ),
              AuthButton(
                text: "local login",
                icon: const FaIcon(
                  FontAwesomeIcons.user,
                ),
                onTap: () => _onLocalLoginTap(context),
              ),
              Gaps.v14,
              const AuthButton(
                text: "Google login",
                icon: FaIcon(
                  FontAwesomeIcons.google,
                ),
              ),
              Gaps.v14,
              const AuthButton(
                text: "Apple login",
                icon: FaIcon(
                  FontAwesomeIcons.apple,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('이미 계정있나용?'),
            Gaps.h2,
            GestureDetector(
              onTap: () => _onSignUpTap(context),
              child: const Text('회원가입하기'),
            ),
          ],
        ),
      ),
    );
  }
}
