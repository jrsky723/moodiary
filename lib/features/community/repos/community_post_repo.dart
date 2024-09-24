import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/community/models/community_post.dart';

class CommunityPostRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> fetchPosts(
    int? lastItemCreatedAt,
  ) {
    final query = _db
        .collection('community')
        .orderBy('createdAt', descending: true)
        .limit(5);
    if (lastItemCreatedAt == null) {
      return query.get();
    } else {
      return query.startAfter([lastItemCreatedAt]).get();
    }
  }

  uploadPost({required CommunityPost post, required String diaryId}) async {
    await _db.collection('community').doc(diaryId).set(post.toJson());
  }
}

final communityPostRepo = Provider((ref) => CommunityPostRepo());
