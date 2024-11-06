import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/features/authentication/view_models/signup_view_model.dart';
import 'package:moodiary/features/authentication/views/widgets/common_form_screen.dart';
import 'package:moodiary/features/authentication/views/widgets/form_button.dart';
import 'package:moodiary/features/authentication/views/widgets/common_input_field.dart';
import 'package:moodiary/generated/l10n.dart';

class EmailScreen extends ConsumerStatefulWidget {
  final String username;
  const EmailScreen({
    super.key,
    required this.username,
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

  void _onSubmit() {
    if (_isButtonDisabled) return;
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {
      ...state,
      "email": _email,
      "password": _password
    };
    ref.read(signUpProvider.notifier).signUp(context);
  }

  //  pwd valid 와 email valid 둘다 체크해서 error message 띄우기
  String? _isValid() {
    if (_isEmailValid() != null || _isPwdValid() != null) {
      return S.of(context).emailAndPasswordAreNotValid;
    }
    return null;
  }

  String? _isEmailValid() {
    if (_email.isEmpty) {
      return null;
    }

    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(_email)) {
      return S.of(context).emailNotValid;
    }
    return null;
  }

  String? _isPwdValid() {
    // TODO : submit 보낼떄만 error 메시지 나오도록 수정

    List<String> errors = [];

    if (_password.isEmpty) {
      return null;
    }

    if (_password.length < 8 || _password.length > 20) {
      errors.add(S.of(context).pwdlengtherror);
    }

    if (errors.isEmpty) {
      return null;
    } else {
      return errors.join('\n');
    }
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
      title: S.of(context).usernameTitle(widget.username),
      children: [
        CommonInputField(
          controller: _emailController,
          hintText: S.of(context).email,
          onChanged: (value) {
            setState(() {
              _email = value;
              _isButtonDisabled = _isValid() != null;
            });
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
                    ? const FaIcon(FontAwesomeIcons.eye)
                    : const FaIcon(FontAwesomeIcons.eyeSlash),
              ),
            ],
          ),
          onChanged: (value) {
            setState(() {
              _password = value;
              _isButtonDisabled = _isValid() != null;
            });
          },
          errorText: _isPwdValid(),
        ),
        Gaps.v20,
        FormButton(
          disabled: _isButtonDisabled,
          onTap: _onSubmit,
          text: S.of(context).completeBtn,
        ),
      ],
    );
  }
}
