import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/features/authentication/view_models/signup_view_model.dart';
import 'package:moodiary/features/authentication/views/avatar_screen.dart';
import 'package:moodiary/features/authentication/views/widgets/common_form_screen.dart';
import 'package:moodiary/features/authentication/views/widgets/common_input_field.dart';
import 'package:moodiary/features/authentication/views/widgets/form_button.dart';
import 'package:moodiary/generated/l10n.dart';

class UsernameScreen extends ConsumerStatefulWidget {
  static const String routeName = 'username';
  static const String routeUrl = '/username';

  const UsernameScreen({super.key});

  @override
  ConsumerState<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends ConsumerState<UsernameScreen> {
  final TextEditingController _usernameController = TextEditingController();

  String _username = "";
  bool _isButtonDisabled = true;

  @override
  void initState() {
    super.initState();

    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
        _isButtonDisabled = _username.length < 3;
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _onNextTap() async {
    if (_isButtonDisabled) return;
    final isValid = await ref
        .read(signUpProvider.notifier)
        .checkUsername(context, _username);
    if (!isValid) return;
    final singUpForm = ref.read(signUpForm);
    ref.read(signUpForm.notifier).state = {
      ...singUpForm,
      "username": _username
    };
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AvatarScreen(username: _username),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonFormScreen(
      appBarTitle: S.of(context).signUp,
      title: S.of(context).createUsername,
      description: S.of(context).usernameDiscription,
      children: [
        CommonInputField(
          controller: _usernameController,
          hintText: S.of(context).userName,
          onChanged: (value) {
            setState(() {
              _isButtonDisabled = value.length < 3;
            });
          },
        ),
        Gaps.v20,
        FormButton(
          disabled: _isButtonDisabled || ref.watch(signUpProvider).isLoading,
          onTap: _onNextTap,
          text: S.of(context).nextBtn,
        ),
      ],
    );
  }
}
