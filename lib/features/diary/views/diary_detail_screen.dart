import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/calendar/view_models/calendar_view_model.dart';
import 'package:moodiary/features/community/view_models/community_post_view_model.dart';
import 'package:moodiary/features/diary/view_models/diary_view_model.dart';
import 'package:moodiary/features/diary/views/edit_diary_screen.dart';
import 'package:moodiary/features/diary/views/widgets/diary_detail/insight_pages.dart';
import 'package:moodiary/features/diary/views/widgets/diary_detail/image_slider.dart';
import 'package:moodiary/features/diary/views/widgets/diary_detail/mood_analysis_card.dart';
import 'package:moodiary/features/diary/views/widgets/diary_detail/text_page_view.dart.dart';
import 'package:moodiary/features/diary/views/widgets/diary_detail/word_cloud_card.dart';
import 'package:moodiary/features/users/view_models/user_posts_view_model.dart';
import 'package:moodiary/generated/l10n.dart';
import 'package:moodiary/utils/build_utils.dart';

class DiaryDetailScreen extends ConsumerStatefulWidget {
  static const String routeName = 'diary';
  static const String routeUrl = '/diary/:diaryId';
  final String diaryId;
  final DateTime date;
  const DiaryDetailScreen({
    super.key,
    required this.diaryId,
    required this.date,
  });

  @override
  ConsumerState<DiaryDetailScreen> createState() => _DiaryDetailScreenState();
}

class _DiaryDetailScreenState extends ConsumerState<DiaryDetailScreen> {
  void _onEdit() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditDiaryScreen(
          diaryId: widget.diaryId,
        ),
      ),
    );
  }

  void refresh() {
    ref.read(calendarProvider.notifier).refresh(widget.date);
    ref.read(userPostsProvider.notifier).refresh();
    ref.read(communityPostProvider.notifier).refresh();
  }

  void _onDeletePressed() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.of(context).deleteDiary),
          content: Text(S.of(context).deleteDiaryMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(S.of(context).cancel),
            ),
            TextButton(
              onPressed: _onDelete,
              child: Text(S.of(context).delete),
            ),
          ],
        );
      },
    );
  }

  void _onDelete() async {
    try {
      await ref
          .read(diaryProvider(widget.diaryId).notifier)
          .deleteDiary(widget.diaryId);

      // 삭제 성공 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).deleteDiarySuccessMessage),
        ),
      );
      //  캘린더 refresh
      refresh();

      // AlertDialog 닫기
      Navigator.pop(context);

      // 다이어리 상세 화면 닫기
      Navigator.pop(context);
    } catch (e) {
      // 삭제 실패 시 에러 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).deleteDiaryErrorMessage),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DateFormat.yMMMMd().format(widget.date),
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _onEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _onDeletePressed,
          ),
        ],
        surfaceTintColor: Colors.transparent,
      ),
      body: ref.watch(diaryProvider(widget.diaryId)).when(
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
            data: (diary) {
              final offset = Offset(diary.offsetX, diary.offsetY);
              // final moodCloudUrl = diary.moodCloudUrl;
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size16,
                ),
                child: ListView(
                  children: [
                    Gaps.v16,
                    _buildDiarySection(context,
                        height: 300.0, content: diary.content),
                    _buildImageSection(
                        height: 100.0, imageUrls: diary.imageUrls),
                    Gaps.v4,
                    _buildAnalysisSection(
                      context, height: 180.0,
                      offset: offset,
                      // moodCloudUrl: moodCloudUrl,
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }

  Widget _buildDiarySection(
    BuildContext context, {
    required double height,
    required String content,
  }) {
    final darkmode = isDarkMode(context);
    return Container(
      height: height,
      padding: const EdgeInsets.only(
        left: Sizes.size16,
        right: Sizes.size16,
        top: Sizes.size18,
        bottom: Sizes.size12,
      ),
      decoration: BoxDecoration(
        color: darkmode ? Colors.transparent : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2.0,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return TextPageView(
            text: content,
            textStyle: const TextStyle(
              fontSize: Sizes.size16,
              height: 1.3,
            ),
            constraints: constraints,
          );
        },
      ),
    );
  }

  Widget _buildImageSection({
    required double height,
    required List<String> imageUrls,
  }) {
    return SizedBox(
      height: height,
      child: ImageSlider(
        imageUrls: imageUrls,
      ),
    );
  }

  Widget _buildAnalysisSection(
    BuildContext context, {
    required double height,
    required Offset offset,
  }) {
    final darkmode = isDarkMode(context);
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size12,
        vertical: Sizes.size12,
      ),
      decoration: BoxDecoration(
        color: darkmode ? Colors.transparent : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2.0,
        ),
      ),
      child: InsightPages(
        pages: [
          MoodAnalysisCard(
            moodOffset: offset,
          ),
          const WorldCloudCard(
            imageUrl: 'assets/images/wordcloud.png',
          ),
        ],
      ),
    );
  }
}
