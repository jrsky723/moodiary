import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/community/view_models/community_post_view_model.dart';
import 'package:moodiary/features/community/views/widgets/post_widget.dart';
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
                    final post = posts[postIndex];
                    return PostWidget(post: post);
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
