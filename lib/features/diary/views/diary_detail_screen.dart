import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/diary/view_models/diary_detail_view_model.dart';
import 'package:moodiary/features/diary/views/widgets/diary_detail/insight_pages.dart';
import 'package:moodiary/features/diary/views/widgets/diary_detail/image_slider.dart';
import 'package:moodiary/features/diary/views/widgets/diary_detail/mood_analysis_card.dart';
import 'package:moodiary/features/diary/views/widgets/diary_detail/text_page_view.dart.dart';
import 'package:moodiary/features/diary/views/widgets/diary_detail/word_cloud_card.dart';
import 'package:moodiary/utils/build_utils.dart';

class DiaryDetailScreen extends ConsumerStatefulWidget {
  final DateTime date;

  const DiaryDetailScreen({
    super.key,
    required this.date,
  });

  @override
  ConsumerState<DiaryDetailScreen> createState() => _DiaryDetailScreenState();
}

class _DiaryDetailScreenState extends ConsumerState<DiaryDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
        surfaceTintColor: Colors.transparent,
      ),
      body: ref
          .watch(diaryDetailProvider(
            widget.date,
          ))
          .when(
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
            data: (diary) {
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
                    _buildAnalysisSection(context, height: 180.0),
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
      child: const InsightPages(
        pages: [
          MoodAnalysisCard(
            moodOffset: Offset(-0.5, -0.2),
          ),
          WorldCloudCard(
            imageUrl: 'assets/images/wordcloud.png',
          ),
        ],
      ),
    );
  }
}
