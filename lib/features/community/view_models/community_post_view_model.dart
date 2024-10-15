import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/community/models/community_post.dart';
import 'package:moodiary/features/community/repos/community_post_repo.dart';

class CommunityPostViewModel
    extends AutoDisposeAsyncNotifier<List<CommunityPost>> {
  late final CommunityPostRepo _repo;
  late List<CommunityPost> _list;

  @override
  FutureOr<List<CommunityPost>> build() async {
    _repo = ref.read(communityPostRepo);
    _list = await _fetchPosts();
    return _list;
  }

  Future<List<CommunityPost>> _fetchPosts({
    int? lastItemCreatedAt,
  }) async {
    final result = await _repo.fetchPosts(lastItemCreatedAt);
    final posts = result.docs.map(
      (doc) => CommunityPost.fromJson(
        json: doc.data(),
      ),
    );
    return posts.toList();
  }

  Future<void> loadMore() async {
    final nextPosts = await _fetchPosts(
      lastItemCreatedAt: _list.last.createdAt,
    );
    _list = [..._list, ...nextPosts];
    state = AsyncValue.data(_list);
  }

  Future<void> refresh() async {
    final posts = await _fetchPosts();
    _list = posts;
    state = AsyncValue.data(_list);
  }
}

final communityPostProvider = AutoDisposeAsyncNotifierProvider<
    CommunityPostViewModel, List<CommunityPost>>(
  () => CommunityPostViewModel(),
);
