import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodiary/common/main_navigation_screen.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/users/models/user_profile_model.dart';
import 'package:moodiary/features/users/view_models/avatar_view_model.dart';
import 'package:moodiary/features/users/view_models/user_profile_view_model.dart';
import 'package:moodiary/generated/l10n.dart';

class CreateProfileScreen extends ConsumerStatefulWidget {
  final String username;
  static const routeName = 'create-profile';
  static const routeUrl = '/create-profile';

  const CreateProfileScreen({
    super.key,
    required this.username,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<CreateProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  UserProfileModel _userProfile = UserProfileModel.empty();

  @override
  void initState() {
    super.initState();
    _userProfile = _userProfile.copyWith(username: widget.username);
  }

  bool _isLoading = false; // 로딩 상태를 관리
  final ImagePicker _picker = ImagePicker();

  // 카메라 또는 갤러리에서 이미지 선택 및 서버에 업로드
  Future<void> _onImageSelected(
      ImageSource source, FormFieldState<bool> state) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _isLoading = true;
      });

      File imageFile = File(pickedFile.path);

      // 이미지 업로드
      await ref.read(avatarProvider.notifier).uploadAvatar(imageFile);
      // 이미지 업로드 성공 시 hasAvatar를 true로 설정

      setState(() {
        state.didChange(true); // FormField의 값 변경
        // _formData['avatarUrl'] = _formData['avatarUrl']; // formData에 저장
        _formData['hasAvatar'] = true; // formData에 저장
        _isLoading = false;
      });
    }
  }

  // 기본 프로필로 변경
  void _resetToDefaultProfile(FormFieldState<bool> state) {
    setState(() {
      state.didChange(false); // FormField의 값 변경
      _formData['hasAvatar'] = false;
    });
  }

  // 이미지 선택 옵션을 보여주는 함수
  void _showImageSourceSelection(
      BuildContext context, FormFieldState<bool> state) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(S.of(context).takePhoto),
                onTap: () {
                  Navigator.pop(context);
                  _onImageSelected(ImageSource.camera, state);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: Text(S.of(context).selectFromGallery),
                onTap: () {
                  Navigator.pop(context);
                  _onImageSelected(ImageSource.gallery, state);
                },
              ),
              if (_formData['hasAvatar'] == true || _userProfile.hasAvatar)
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(S.of(context).resetToDefaultProfile),
                  onTap: () {
                    Navigator.pop(context);
                    _resetToDefaultProfile(state);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  // 폼 저장 함수
  void onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        ref.read(usersProvider.notifier).updateUserProfile(_formData);
        ref
            .read(usersProvider.notifier)
            .updateCommunityOwnerByDiaryId(_formData);
        context.go('/${MainNavigationScreen.initialTab}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필 만들기'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(Sizes.size16),
          children: [
            // 이미지 선택 및 업로드 로딩 상태 관리

            FormField<bool>(
              initialValue: _userProfile.hasAvatar,
              builder: (state) {
                final hasAvatar = state.value ?? false;
                return Center(
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 75,
                          backgroundImage: hasAvatar
                              ? NetworkImage(
                                  "https://firebasestorage.googleapis.com/v0/b/moodiary-b37ca.appspot.com/o/avatars%2F${_userProfile.uid}?alt=media&test=${DateTime.now().millisecondsSinceEpoch}",
                                )
                              : null,
                          child: Text(
                            _userProfile.username[0],
                            style: const TextStyle(fontSize: Sizes.size44),
                          ),
                        ),
                        if (_isLoading)
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: () =>
                                  _showImageSourceSelection(context, state),
                              child: const Icon(FontAwesomeIcons.plus),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              onSaved: (newValue) {
                if (newValue != null) _formData['hasAvatar'] = newValue;
              },
            ),
            Gaps.v16,
            // 사용자 이름 입력 필드
            TextFormField(
              readOnly: true,
              initialValue: _userProfile.username,
              decoration: InputDecoration(labelText: S.of(context).userName),
              maxLength: 16,
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 2) {
                  return S.of(context).userNameMinError;
                }
                return null;
              },
              onSaved: (newValue) {
                if (newValue != null) _formData['username'] = newValue;
              },
            ),
            Gaps.v16,
            // 이름 입력 필드
            TextFormField(
              initialValue: _userProfile.nickname,
              decoration: InputDecoration(labelText: S.of(context).nickname),
              maxLength: 16,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).pleaseEnterName;
                }
                return null;
              },
              onSaved: (newValue) {
                if (newValue != null) _formData['nickname'] = newValue;
              },
            ),
            Gaps.v16,

            // 이메일 입력 필드

            // 소개 입력 필드
            TextFormField(
              initialValue: _userProfile.bio,
              decoration: InputDecoration(labelText: S.of(context).bio),
              maxLength: 50,
              onSaved: (newValue) {
                if (newValue != null) _formData['bio'] = newValue;
              },
            ),
            Gaps.v16,
            // 저장 버튼
            ElevatedButton(
              onPressed: onSubmitTap,
              child: Text(S.of(context).save),
            ),
          ],
        ),
      ),
    );
  }
}
