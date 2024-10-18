import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/diary/models/diary_model.dart';
import 'package:moodiary/features/diary/view_models/diary_view_model.dart';

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

  // 수정된 일기 저장
  void _onSubmitTap(DiaryModel diary) {
    // isImageDeleted로 새로운 이미지 URL 목록 생성
    List<String> newImageUrs = [];
    for (int i = 0; i < diary.imageUrls.length; i++) {
      if (!_isImageDeleted[i]) {
        newImageUrs.add(diary.imageUrls[i]);
      }
    }

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ref.read(diaryProvider(widget.diaryId).notifier).updateDiary(
            diaryId: widget.diaryId,
            content: formData['content']!,
            imageUrls: newImageUrs,
            isPublic: diary.isPublic,
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
        const SnackBar(
          content: Text('At least one image must be kept'),
          duration: Duration(seconds: 2),
        ),
      );
      _isSnackBarVisible = true;
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isSnackBarVisible = false;
        });
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
          title: const Text("Edit Diary"),
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
                          "Diary Content",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Gaps.v12,
                        _buildDiarySection(
                          content: diary.content,
                        ),
                        Gaps.v32,
                        Text(
                          "Images",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Gaps.v20,
                        _buildImageSection(
                          imageUrls: diary.imageUrls,
                        ),
                        Gaps.v20,
                        ElevatedButton(
                          onPressed: () => _onSubmitTap(diary),
                          child: Text(
                            "Submit",
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

  Widget _buildDiarySection({
    required String content,
  }) {
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
          hintText: "Enter your diary content",
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
            return 'Please enter some content';
          }
          return null;
        },
      ),
    );
  }

  // 이미지 섹션 (삭제 상태를 시각적으로 표현)
  Widget _buildImageSection({
    required List<String> imageUrls,
  }) {
    if (imageUrls.isEmpty) {
      return const Text('No images available');
    }
    const sectionHeight = 120.0;
    return SizedBox(
      height: sectionHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // 가로 스크롤
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          final imageUrl = imageUrls[index];
          return StatefulBuilder(
            builder: (context, setState) {
              return Stack(
                children: [
                  // 이미지 컨테이너
                  Container(
                    width: sectionHeight, // 이미지의 가로 크기 (정사각형으로 설정)
                    height: sectionHeight, // 이미지의 세로 크기 (정사각형으로 설정)
                    margin: const EdgeInsets.symmetric(horizontal: Sizes.size2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 5,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover, // 이미지를 정사각형에 맞게 채움
                      ),
                    ),
                    child: _isImageDeleted[index] // 이미지 삭제 상태일 때
                        ? Container(
                            width: sectionHeight,
                            height: sectionHeight,
                            color: Colors.black.withOpacity(0.5), // 어두운 레이어 추가
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

                  // 삭제 버튼
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
}
