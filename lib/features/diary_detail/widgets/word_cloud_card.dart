import 'package:flutter/material.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/diary_detail/widgets/info_image_button.dart';
import 'package:moodiary/generated/l10n.dart';

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
        Text(
          S.of(context).moodCloud,
          style: const TextStyle(
            fontSize: Sizes.size18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gaps.v8,
        Expanded(
          child: Center(
            child: SizedBox(
              width: double.infinity,
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
          ),
        ),
      ],
    );
  }
}
