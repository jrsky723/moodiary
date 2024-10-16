import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/features/authentication/view_models/login_view_model.dart';
import 'package:moodiary/features/authentication/views/widgets/common_form_screen.dart';
import 'package:moodiary/features/authentication/views/widgets/common_input_field.dart';
import 'package:moodiary/generated/l10n.dart';
import 'package:moodiary/features/authentication/views/widgets/form_button.dart';

class LoginFormScreen extends ConsumerStatefulWidget {
  const LoginFormScreen({super.key});

  @override
  ConsumerState<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends ConsumerState<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isObscure = true;
  Map<String, String> formData = {};

  void _onSubmitTap() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ref.read(loginProvider.notifier).login(
            formData['email']!,
            formData['password']!,
            context,
          );
    }
  }

  void _onClearTap() {
    _passwordController.clear();
  }

  void _toggleObscureText() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonFormScreen(
      appBarTitle: S.of(context).login,
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              CommonInputField(
                controller: _emailController,
                hintText: 'Email',
                onChanged: (value) {
                  formData['email'] = value;
                },
              ),
              Gaps.v16,
              CommonInputField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: _isObscure,
                onChanged: (value) {
                  formData['password'] = value;
                },
                suffix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: _onClearTap,
                      child: const FaIcon(FontAwesomeIcons.circleXmark),
                    ),
                    Gaps.h10,
                    GestureDetector(
                      onTap: _toggleObscureText,
                      child: FaIcon(
                        _isObscure
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                      ),
                    ),
                  ],
                ),
              ),
              Gaps.v28,
              FormButton(
                disabled: ref.watch(loginProvider).isLoading,
                onTap: _onSubmitTap,
                text: S.of(context).login,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
