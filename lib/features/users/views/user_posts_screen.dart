import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:moodiary/features/community/views/widgets/post_widget.dart';
import 'package:moodiary/features/users/view_models/user_posts_view_model.dart';

class UserPostsScreen extends ConsumerStatefulWidget {
  final int index; // 초기 시작 인덱스
  final String username;

  const UserPostsScreen({
    super.key,
    required this.index,
    required this.username,
  });

  @override
  ConsumerState<UserPostsScreen> createState() => _UserPostsScreenState();
}

class _UserPostsScreenState extends ConsumerState<UserPostsScreen> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _jumpToIndex(widget.index);
    });
  }

  void _jumpToIndex(int index) {
    if (_itemScrollController.isAttached) {
      _itemScrollController.jumpTo(index: index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ref.watch(userPostsProvider).when(
        data: (posts) {
          return Column(
            children: [
              AppBar(
                title: Text(widget.username),
                backgroundColor: Colors.transparent,
                elevation: 0,
                surfaceTintColor: Colors.transparent,
              ),
              Expanded(
                child: ScrollablePositionedList.builder(
                  itemScrollController: _itemScrollController,
                  itemPositionsListener: _itemPositionsListener,
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: PostWidget(post: post), // 게시물 위젯
                    );
                  },
                ),
              ),
            ],
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
    );
  }
}
