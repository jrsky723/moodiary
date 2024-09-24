import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/community/view_models/community_post_view_model.dart';
import 'package:moodiary/features/community/views/widgets/post_page_view.dart';
import 'package:moodiary/features/community/views/widgets/post_content.dart';
import 'package:moodiary/features/users/models/user_profile_model.dart';
import 'package:moodiary/generated/l10n.dart';

class CommunityScreen extends ConsumerStatefulWidget {
  const CommunityScreen({super.key});

  @override
  ConsumerState<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen> {
  int _itemCount = 0;
  final bool _isLoadingMore = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() async {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll * 0.85 < currentScroll && !_isLoadingMore) {
      _loadMorePosts();
    }
  }

  Future<void> _loadMorePosts() async {
    return ref.read(communityPostProvider.notifier).loadMore();
  }

  Future<void> _onRefresh() {
    return ref.read(communityPostProvider.notifier).refresh();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildUserSection(UserProfileModel owner, DateTime date) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: owner.hasAvatar ? NetworkImage(owner.avatarUrl) : null,
        child: Text(
          owner.hasAvatar
              ? ''
              : owner.username == ''
                  ? 'U'
                  : owner.username[0],
          style: const TextStyle(fontSize: Sizes.size24),
        ),
      ),
      title: Text(owner.username),
      subtitle: Text(
        DateFormat.yMMMd().format(date),
        style: const TextStyle(
          color: Colors.grey,
          fontSize: Sizes.size12,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text(S.of(context).communityTitle),
                floating: true,
                snap: true,
                surfaceTintColor: Colors.transparent,
                shadowColor: Colors.black,
              ),
            ];
          },
          body: ref.watch(communityPostProvider).when(
            data: (posts) {
              _itemCount = posts.length;
              return RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.builder(
                  itemCount: _itemCount + 1, // +1 for loading indicator
                  itemBuilder: (context, postIndex) {
                    if (postIndex == _itemCount) {
                      if (_isLoadingMore) {
                        return const Padding(
                          padding: EdgeInsets.all(Sizes.size16),
                          child: Center(
                            child: SizedBox(
                              width: Sizes.size24,
                              height: Sizes.size24,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }
                    final owner = posts[postIndex].owner;
                    final imageUrls = posts[postIndex].imageUrls;
                    final content = posts[postIndex].content;
                    final date = posts[postIndex].date;
                    return Column(
                      children: [
                        // UserSection
                        _buildUserSection(owner, date),
                        // PostPageView
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.width - Sizes.size16,
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
                  },
                ),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            error: (error, stackTrace) {
              return Center(
                child: Text(
                  error.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
