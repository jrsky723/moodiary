import 'package:flutter/material.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/community/models/community_post.dart';
import 'package:moodiary/features/community/views/widgets/post_content.dart';
import 'package:moodiary/features/community/views/widgets/post_page_view.dart';
import 'package:moodiary/features/community/views/widgets/post_user.dart';

class PostWidget extends StatelessWidget {
  final CommunityPost post;

  const PostWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final owner = post.owner;
    final imageUrls = post.imageUrls;
    final content = post.content;
    final date = post.date;
    return Column(
      children: [
        // UserSection
        PostUser(owner: owner, date: date),
        // PostPageView
        SizedBox(
          height: MediaQuery.of(context).size.width - Sizes.size16,
          child: PostPageView(
            imageUrls: imageUrls,
          ),
        ),
        Gaps.v10,
        // PostContent
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size16,
          ),
          child: PostContent(
            username: owner.username,
            content: content,
          ),
        ),
        Gaps.v20,
        const Divider(
          height: Sizes.size1,
          thickness: 1,
          color: Colors.white,
        ),
      ],
    );
  }
}
