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
    await ref.read(userProfileProvider.notifier).createProfile();
    if (mounted) context.go('/${MainNavigationScreen.initialTab}');
  }

  String? _isValid() {
    if (_nickname.isEmpty) {
      return null;
    }
    if (_isButtonDisabled) return S.of(context).nicknameValidError;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return CommonFormScreen(
      appBarTitle: S.of(context).signUp,
      title: S.of(context).createProfile,
      description: S.of(context).nickBioDiscription,
      children: [
        CommonInputField(
          controller: _nicknameController,
          hintText: S.of(context).nickname,
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
          hintText: S.of(context).bio,
          onChanged: (value) {
            setState(() {
              _bio = value;
            });
          },
        ),
        Gaps.v20,
        FormButton(
          disabled:
              _isButtonDisabled || ref.watch(userProfileProvider).isLoading,
          onTap: _onNextTap,
          text: S.of(context).completeBtn,
        ),
      ],
    );
  }
}
