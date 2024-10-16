import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodiary/common/main_navigation_screen.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/features/authentication/view_models/signup_view_model.dart';
import 'package:moodiary/features/authentication/views/widgets/common_form_screen.dart';
import 'package:moodiary/features/authentication/views/widgets/form_button.dart';
import 'package:moodiary/features/authentication/views/widgets/common_input_field.dart';
import 'package:moodiary/features/users/view_models/user_profile_view_model.dart';
import 'package:moodiary/generated/l10n.dart';

class NicknameBioScreen extends ConsumerStatefulWidget {
  const NicknameBioScreen({super.key});

  @override
  ConsumerState<NicknameBioScreen> createState() => _NicknameBioScreenState();
}

class _NicknameBioScreenState extends ConsumerState<NicknameBioScreen> {
  late final TextEditingController _nicknameController =
      TextEditingController();
  late final TextEditingController _bioController = TextEditingController();

  String _nickname = "";
  String _bio = "";
  bool _isButtonDisabled = true;

  void _onNextTap() async {
    if (_isButtonDisabled) return;
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {
      ...state,
      "nickname": _nickname,
      "bio": _bio,
    };
    await ref.read(usersProvider.notifier).createProfile();
    context.go('/${MainNavigationScreen.initialTab}');
  }

  String? _isValid() {
    if (_nickname.isEmpty) {
      return null;
    }
    if (_isButtonDisabled) return "Nickname have to be at least 3 characters";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return CommonFormScreen(
      appBarTitle: "Sign Up",
      title: "Create Profile",
      description: "You can always change this later",
      children: [
        CommonInputField(
          controller: _nicknameController,
          hintText: "Nickname",
          onChanged: (value) {
            setState(() {
              _nickname = value;
              _isButtonDisabled = value.length < 3;
            });
          },
          errorText: _isValid(),
        ),
        Gaps.v20,
        CommonInputField(
          controller: _bioController,
          hintText: "Bio",
          onChanged: (value) {
            setState(() {
              _bio = value;
            });
          },
        ),
        Gaps.v20,
        FormButton(
          disabled: _isButtonDisabled,
          onTap: _onNextTap,
          text: S.of(context).completeBtn,
        ),
      ],
    );
  }
}
