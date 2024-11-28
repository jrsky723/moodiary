import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/authentication/repos/authentication_repo.dart';
import 'package:moodiary/features/authentication/view_models/signup_view_model.dart';
import 'package:moodiary/features/authentication/views/nickname_bio_screen.dart';
import 'package:moodiary/features/authentication/views/widgets/form_button.dart';
import 'package:moodiary/features/users/view_models/avatar_view_model.dart';
import 'package:moodiary/generated/l10n.dart';

class AvatarScreen extends ConsumerStatefulWidget {
  static const String routeName = 'avatar';
  static const String routeUrl = '/avatar';

  final String username;
  const AvatarScreen({
    super.key,
    required this.username,
  });

  @override
  ConsumerState<AvatarScreen> createState() => _AvatarScreenState();
}

class _AvatarScreenState extends ConsumerState<AvatarScreen> {
  bool _isLoading = false; // 로딩 상태를 관리
  bool _hasAvatar = false; // 이미지가 있는지 여부를 관리
  final ImagePicker _picker = ImagePicker();

  Future<void> _onImageSelected(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _isLoading = true;
      });

      File imageFile = File(pickedFile.path);
      try {
        // 이미지 업로드
        await ref.read(avatarProvider.notifier).uploadAvatar(imageFile);
        // 이미지 업로드 성공 시 hasAvatar를 true로 설정
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
      setState(() {
        _hasAvatar = true;
        _isLoading = false;
      });
    }
  }

  // 기본 프로필로 변경
  void _resetToDefaultProfile() {
    setState(() {
      _hasAvatar = false;
    });
  }

  void _onSubmit() {
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {
      ...state,
      'hasAvatar': _hasAvatar,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NicknameBioScreen(),
      ),
    );
  }

  // 이미지 선택 옵션을 보여주는 함수
  void _showImageSourceSelection(BuildContext context) {
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
                  _onImageSelected(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: Text(S.of(context).selectFromGallery),
                onTap: () {
                  Navigator.pop(context);
                  _onImageSelected(ImageSource.gallery);
                },
              ),
              if (_hasAvatar == true)
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(S.of(context).resetToDefaultProfile),
                  onTap: () {
                    Navigator.pop(context);
                    _resetToDefaultProfile();
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //  아래 이미지 불러올때 사용할  uid
    final uid = ref.read(authRepo).user!.uid;
    final avatarUrl = dotenv.env['AVATAR_URL']!
        .replaceAll('{uid}', uid)
        .replaceAll(
            '{timestamp}', DateTime.now().millisecondsSinceEpoch.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).createProfile),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: 150,
                height: 150,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 75,
                      foregroundImage: _hasAvatar
                          ? NetworkImage(
                              avatarUrl,
                            )
                          : null,
                      child: Text(
                        widget.username[0],
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
                          onPressed: () => _showImageSourceSelection(context),
                          child: const Icon(FontAwesomeIcons.plus),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gaps.v20,
            FormButton(
              disabled: _isLoading,
              onTap: _onSubmit,
              text: S.of(context).nextBtn,
            ),
          ],
        ),
      ),
    );
  }
}
