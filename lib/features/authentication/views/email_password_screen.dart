import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/features/authentication/view_models/signup_view_model.dart';
import 'package:moodiary/features/authentication/views/username_screen.dart';
import 'package:moodiary/features/authentication/views/widgets/common_form_screen.dart';
import 'package:moodiary/features/authentication/views/widgets/form_button.dart';
import 'package:moodiary/features/authentication/views/widgets/common_input_field.dart';
import 'package:moodiary/generated/l10n.dart';

class EmailScreen extends ConsumerStatefulWidget {
  const EmailScreen({
    super.key,
  });

  @override
  ConsumerState<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends ConsumerState<EmailScreen> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();

  String _email = "";
  String _password = "";
  bool _isButtonDisabled = true;
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
  }

  void _onSubmit() async {
    if (_isButtonDisabled) return;
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {
      ...state,
      "email": _email,
      "password": _password
    };
    await ref.read(signUpProvider.notifier).signUp(context);
    if (mounted) {
      context.goNamed(
        UsernameScreen.routeName,
      );
    }
  }

  void _isButtonValid() {
    setState(() {
      _email = _emailController.text;
      _password = _passwordController.text;
      _isButtonDisabled = _email.isEmpty ||
          _password.isEmpty ||
          _isEmailValid() != null ||
          _isPwdValid() != null;
    });
  }

  String? _isEmailValid() {
    if (_email.isEmpty) return null;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regExp.hasMatch(_email) ? null : S.of(context).emailNotValid;
  }

  String? _isPwdValid() {
    List<String> errors = [];

    if (_password.isEmpty) return null;

    if (_password.length < 8 || _password.length > 20) {
      errors.add(S.of(context).pwdlengtherror);
    }

    return errors.isEmpty ? null : errors.join('\n');
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
    return CommonFormScreen(
      appBarTitle: S.of(context).signUp,
      title: S.of(context).createAccount,
      children: [
        CommonInputField(
          controller: _emailController,
          hintText: S.of(context).email,
          onChanged: (value) {
            _isButtonValid();
          },
          errorText: _isEmailValid(),
        ),
        Gaps.v20,
        CommonInputField(
          controller: _passwordController,
          hintText: S.of(context).password,
          obscureText: _isObscure,
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
                child: _isObscure
                    ? const FaIcon(FontAwesomeIcons.eyeSlash)
                    : const FaIcon(FontAwesomeIcons.eye),
              ),
            ],
          ),
          onChanged: (value) {
            _isButtonValid();
          },
          errorText: _isPwdValid(),
        ),
        Gaps.v20,
        FormButton(
          disabled: _isButtonDisabled || ref.watch(signUpProvider).isLoading,
          onTap: _onSubmit,
          text: S.of(context).completeBtn,
        ),
      ],
    );
  }
}
