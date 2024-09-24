import 'package:moodiary/features/community/models/community_user.dart';

class CommunityPost {
  final DateTime date;
  final CommunityUser owner;
  final String content;
  final List<String> imageUrls;

  const CommunityPost({
    required this.date,
    required this.owner,
    required this.content,
    required this.imageUrls,
  });
}
