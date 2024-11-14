import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/diary/models/diary_model.dart';
import 'package:moodiary/features/diary/view_models/diary_view_model.dart';
import 'package:moodiary/generated/l10n.dart';

class EditDiaryScreen extends ConsumerStatefulWidget {
  final String diaryId;

  const EditDiaryScreen({super.key, required this.diaryId});

  @override
  ConsumerState<EditDiaryScreen> createState() => _EditDiaryScreenState();
}

class _EditDiaryScreenState extends ConsumerState<EditDiaryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};
  List<bool> _isImageDeleted = [];
  bool _isSnackBarVisible = false;
  bool _isPublic = false; // 공개 여부를 저장할 변수

  @override
  void initState() {
    super.initState();
    // 초기 값을 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final diary = ref.read(diaryProvider(widget.diaryId)).asData?.value;
      if (diary != null) {
        setState(() {
          _isPublic = diary.isPublic;
        });
      }
    });
  }

  // 수정된 일기 저장
  void _onSubmitTap(DiaryModel diary) {
    // 삭제되지 않은 이미지 URL 목록 생성
    List<String> newImageUrls = [];
    for (int i = 0; i < diary.imageUrls.length; i++) {
      if (!_isImageDeleted[i]) {
        newImageUrls.add(diary.imageUrls[i]);
      }
    }

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ref.read(diaryProvider(widget.diaryId).notifier).updateDiary(
            diaryId: int.parse(widget.diaryId),
            content: formData['content']!,
            imageUrls: newImageUrls,
            isPublic: _isPublic, // 현재 공개 여부 전달
          );

      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  void _onImageSelected(index) {
    // 최소 하나의 이미지는 남아있어야 함
    if (_isImageDeleted.where((element) => !element).length > 1) {
      setState(() {
        _isImageDeleted[index] = !_isImageDeleted[index];
      });
    } else {
      if (_isSnackBarVisible) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).OneImageMustBeKept),
          duration: const Duration(seconds: 2),
        ),
      );
      _isSnackBarVisible = true;
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isSnackBarVisible = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).editDiary),
        ),
        body: ref.watch(diaryProvider(widget.diaryId)).when(
              data: (diary) {
                if (_isImageDeleted.length != diary.imageUrls.length) {
                  _isImageDeleted = List.filled(diary.imageUrls.length, false);
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        Gaps.v20,
                        Text(
                          S.of(context).diaryContent,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Gaps.v12,
                        _buildDiarySection(
                          content: diary.content,
                        ),
                        Gaps.v32,
                        Text(
                          S.of(context).images,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Gaps.v20,
                        _buildImageSection(
                          imageUrls: diary.imageUrls,
                        ),
                        Gaps.v20,
                        _buildIsPublicSection(), // 공개 여부 섹션 추가
                        Gaps.v20,
                        ElevatedButton(
                          onPressed: () => _onSubmitTap(diary),
                          child: Text(
                            S.of(context).save,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              error: (error, stackTrace) =>
                  Center(child: Text('Error: $error')),
            ),
      ),
    );
  }

  Widget _buildDiarySection({required String content}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(Sizes.size8),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size12,
        vertical: Sizes.size12,
      ),
      child: TextFormField(
        initialValue: content,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: S.of(context).enterYourDiaryContent,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        onSaved: (newValue) {
          if (newValue != null) {
            formData['content'] = newValue;
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return S.of(context).pleaseEnterSomeContent;
          }
          return null;
        },
      ),
    );
  }

  // 이미지 섹션 (삭제 상태를 시각적으로 표현)
  Widget _buildImageSection({required List<String> imageUrls}) {
    if (imageUrls.isEmpty) {
      return Text(S.of(context).noImagesAvailable);
    }
    const sectionHeight = 120.0;
    return SizedBox(
      height: sectionHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          final imageUrl = imageUrls[index];
          return StatefulBuilder(
            builder: (context, setState) {
              return Stack(
                children: [
                  Container(
                    width: sectionHeight,
                    height: sectionHeight,
                    margin: const EdgeInsets.symmetric(horizontal: Sizes.size2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 5,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: _isImageDeleted[index]
                        ? Container(
                            width: sectionHeight,
                            height: sectionHeight,
                            color: Colors.black.withOpacity(0.5),
                            child: Center(
                              child: Icon(
                                Icons.delete,
                                size: 30,
                                color: Colors.white.withOpacity(0.6),
                              ),
                            ),
                          )
                        : null,
                  ),
                  Positioned(
                    top: -3,
                    right: -3,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: Sizes.size24,
                      ),
                      color: Colors.red.withOpacity(0.8),
                      onPressed: () => _onImageSelected(index),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  // 공개 여부 섹션
  Widget _buildIsPublicSection() {
    return SwitchListTile(
      title: Text(S.of(context).communityBtn),
      subtitle: Text(S.of(context).communityBtnSubtitle),
      value: _isPublic,
      onChanged: (value) {
        setState(() {
          _isPublic = value;
        });
      },
    );
  }
}
