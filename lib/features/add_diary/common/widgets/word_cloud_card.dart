import 'package:flutter/material.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/add_diary/common/widgets/info_image_button.dart';

class WorldCloudCard extends StatelessWidget {
  final String imageUrl;
  const WorldCloudCard({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          // S.of(context).moodCloud,
          '감정 구름',
          style: TextStyle(
            fontSize: Sizes.size18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gaps.v8,
        Expanded(
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.fitWidth,
                ),
              ),
              const Positioned(
                right: 0,
                bottom: 0,
                child: InfoImageButton(
                  isAsset: true,
                  imageUrl: 'assets/images/emotion_colors.png',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
