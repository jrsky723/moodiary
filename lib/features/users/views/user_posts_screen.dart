import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/community/views/widgets/post_widget.dart';
import 'package:moodiary/features/users/view_models/user_posts_view_model.dart';

class UserPostsScreen extends ConsumerStatefulWidget {
  final int index;
  final String username;

  const UserPostsScreen(
      {super.key, required this.index, required this.username});

  @override
  ConsumerState<UserPostsScreen> createState() => _UserPostsScreenState();
}

class _UserPostsScreenState extends ConsumerState<UserPostsScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    // PageController를 초기화하여 처음에 특정 페이지로 시작
    _pageController = PageController(initialPage: widget.index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(widget.username),
              floating: true,
              snap: true,
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.black,
            ),
            SliverToBoxAdapter(
              child: ref.watch(userPostsProvider).when(
                data: (posts) {
                  final itemCount = posts.length;
                  return SizedBox(
                    height: MediaQuery.of(context).size.height, // 페이지 전체 화면 크기
                    child: PageView.builder(
                      scrollDirection: Axis.vertical,
                      controller: _pageController, // PageController 연결
                      itemCount: itemCount,
                      itemBuilder: (context, postIndex) {
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
          ],
        ),
      ),
    );
  }
}
