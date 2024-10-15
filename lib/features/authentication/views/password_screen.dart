import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/authentication/view_models/signup_view_model.dart';
import 'package:moodiary/features/authentication/views/widgets/form_button.dart';
import 'package:moodiary/generated/l10n.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  const PasswordScreen({super.key});

  @override
  ConsumerState<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends ConsumerState<PasswordScreen> {
  late final TextEditingController _passwordController;

  String _password = "";
  bool _isButtonDisabled = true;
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
        _isButtonDisabled = _password.isEmpty || _isValid() != null;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  String? _isValid() {
    // TODO : submit 보낼떄만 error 메시지 나오도록 수정

    List<String> errors = [];

    if (_password.isEmpty) {
      return null;
    }

    if (_password.length < 8 || _password.length > 20) {
      errors.add(S.of(context).pwdlengtherror);
    }

    //  추가적인 validation rule
    // final specialCharRegex = RegExp(r'[!@#\$&*~]');
    // if (!specialCharRegex.hasMatch(_password)) {
    //   errors.add(S.of(context).pwdspecialcharerror);
    // }

    // final uppercaseRegex = RegExp(r'[A-Z]');
    // if (!uppercaseRegex.hasMatch(_password)) {
    //   errors.add(S.of(context).pwduppercaseerror);
    // }

    // final numberRegex = RegExp(r'[0-9]');
    // if (!numberRegex.hasMatch(_password)) {
    //   errors.add(S.of(context).pwdnumbererror);
    // }

    if (errors.isEmpty) {
      return null;
    } else {
      return errors.join('\n');
    }
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (_isValid() != null) return;
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {
      ...state,
      "password": _password,
    };
    ref.read(signUpProvider.notifier).signUp(context);
  }

  void _onClearTap() {
    _passwordController.clear();
  }

  void _toggleObscrueText() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).signUp),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v10,
              const Text(
                "Password",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gaps.v20,
              TextField(
                controller: _passwordController,
                autocorrect: false,
                onEditingComplete: _onSubmit,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _onClearTap,
                        child: const FaIcon(FontAwesomeIcons.circleXmark),
                      ),
                      Gaps.h10,
                      GestureDetector(
                        onTap: _toggleObscrueText,
                        child: const FaIcon(FontAwesomeIcons.eye),
                      ),
                    ],
                  ),
                  hintText: "Make it Strong",
                  errorText: _isValid(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v20,
              FormButton(
                disabled:
                    _isButtonDisabled || ref.watch(signUpProvider).isLoading,
                onTap: _onSubmit,
                text: S.of(context).completeBtn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
