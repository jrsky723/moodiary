import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/users/models/user_profile_model.dart';

class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  // 임시 유저 프로필
  final UserProfileModel _userProfile = UserProfileModel(
    uid: '123456',
    userName: 'Hong111',
    bio: '안녕하세요! 저는 홍길동입니다. 저는 개발밖에 안해요',
    hasAvatar: false,
    avatarUrl: 'https://picsum.photos/id/${1}/200/200',
    name: '홍길동',
  );

  bool _isLoading = false; // 로딩 상태를 관리
  final ImagePicker _picker = ImagePicker();

  // 갤러리에서 이미지 선택 및 서버에 업로드
  Future<void> _onGallaryTap(FormFieldState<bool> state) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _isLoading = true;
      });

      File imageFile = File(pickedFile.path);
      // TODO: 서버로 이미지 업로드 후 URL 받아오는 로직
      // 예를 들어:
      await Future.delayed(const Duration(seconds: 2)); // 업로드 중이라고 가정

      bool isUploaded = true; // 업로드 성공 여부

      if (isUploaded) {
        setState(() {
          state.didChange(true);
          _isLoading = false;
        });
      }
    }
  }

  // 폼 저장 함수
  void onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        print(_formData); // 여기서 서버로 전송하거나 로컬에 저장하는 로직 추가
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필 수정'),
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
                final imageUrl = _userProfile.avatarUrl;
                final hasAvatar = state.value ?? false;
                return Center(
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 75,
                          backgroundImage:
                              hasAvatar ? NetworkImage(imageUrl) : null,
                          child: Text(
                            hasAvatar ? "" : _userProfile.name[0],
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
                              onPressed: () => _onGallaryTap(state),
                              child: const FaIcon(
                                FontAwesomeIcons.image,
                                size: 20,
                              ),
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
              initialValue: _userProfile.userName,
              decoration: const InputDecoration(labelText: '사용자 이름'),
              maxLength: 16,
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 2) {
                  return '사용자 이름은 2자 이상이어야 합니다.';
                }
                return null;
              },
              onSaved: (newValue) {
                if (newValue != null) _formData['userName'] = newValue;
              },
            ),
            Gaps.v16,
            // 이름 입력 필드
            TextFormField(
              initialValue: _userProfile.name,
              decoration: const InputDecoration(labelText: '이름'),
              maxLength: 16,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '이름을 입력해주세요.';
                }
                return null;
              },
              onSaved: (newValue) {
                if (newValue != null) _formData['name'] = newValue;
              },
            ),
            Gaps.v16,
            // 소개 입력 필드
            TextFormField(
              initialValue: _userProfile.bio,
              decoration: const InputDecoration(labelText: '소개'),
              maxLength: 50,
              onSaved: (newValue) {
                if (newValue != null) _formData['bio'] = newValue;
              },
            ),
            Gaps.v16,
            // 저장 버튼
            ElevatedButton(
              onPressed: onSubmitTap,
              child: const Text('저장'),
            ),
          ],
        ),
      ),
    );
  }
}
