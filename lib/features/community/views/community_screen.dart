import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/community/models/community_post.dart';
import 'package:moodiary/features/community/models/community_user.dart';
import 'package:moodiary/features/community/views/widgets/post_page_view.dart';
import 'package:moodiary/features/community/views/widgets/post_content.dart';
import 'package:moodiary/generated/l10n.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with SingleTickerProviderStateMixin {
  int _itemCount = 0;
  bool _isLoading = false;
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  late List<CommunityPost> _posts;

  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _itemCount = 5;
    _posts = _generateRandomPosts(5);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading) {
        _loadMorePosts();
      }
    });
  }

  List<CommunityPost> _generateRandomPosts(int count) {
    final List<CommunityPost> posts = [];
    for (int i = 0; i < count; i++) {
      final randomId = i + 1;
      posts.add(
        CommunityPost(
          date: DateTime.now(),
          owner: CommunityUser(
            uid: '$randomId',
            username: 'User$randomId',
            hasAvatar: _random.nextBool(),
            avatarUrl: 'https://picsum.photos/id/$randomId/200/200',
          ),
          content:
              '''이렇게 하면 서버가 제공하는 REST API와 통신하여, 원격 관계형 데이터베이스에서 데이터를 가져올 수 있습니다.
장점:
	•	복잡한 데이터 구조 처리 가능: 서버 기반 관계형 데이터베이스는 대규모 데이터 처리와 복잡한 관계형 데이터 모델링에 적합합니다.
	•	보안: API 계층을 통해 데이터베이스와 통신하므로 보안과 데이터 검증을 서버 측에서 처리할 수 있습니다.
단점:
	•	오프라인 사용 불가: Flutter 앱 자체에서 오프라인 상태로는 사용할 수 없습니다.
	•	네트워크 의존성: 네트워크 연결 상태에 따라 성능에 영향을 받을 수 있습니다.
결론:
	•	오프라인 저장소가 필요하고 앱 내에서 간단한 관계형 데이터베이스를 사용하려면 SQLite(예: sqflite 패키지)를 사용하는 것이 적합합니다.
	•	원격 서버에 있는 대규모 데이터베이스와 통신해야 한다면 REST API 또는 GraphQL을 통해 Flutter와 서버를 연결하고, 서버에서는 MySQL/PostgreSQL과 같은 관계형 데이터베이스를 사용할 수 있습니다.
두 방식 중 요구사항에 맞는 방법을 선택하시면 됩니다.  
      ''',
          imageUrls: [
            for (int j = 1; j <= randomId; j++)
              'https://picsum.photos/id/${randomId + j}/200/200',
          ],
        ),
      );
    }
    return posts;
  }

  Future<void> _loadMorePosts() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _itemCount += 5;
      _posts.addAll(_generateRandomPosts(5));
    });
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _refreshPosts() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _itemCount = 5;
      _posts = _generateRandomPosts(5);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildUserSection(CommunityUser owner, DateTime date) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: owner.hasAvatar ? NetworkImage(owner.avatarUrl) : null,
        child: Text(
          owner.hasAvatar ? '' : owner.username[0],
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
          body: RefreshIndicator(
            onRefresh: _refreshPosts,
            child: ListView.builder(
              itemCount: _posts.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, postIndex) {
                if (postIndex == _posts.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                final owner = _posts[postIndex].owner;
                final imageUrls = _posts[postIndex].imageUrls;
                final content = _posts[postIndex].content;
                final date = _posts[postIndex].date;
                return Column(
                  children: [
                    _buildUserSection(owner, date),
                    SizedBox(
                      height: MediaQuery.of(context).size.width - Sizes.size16,
                      child: PostPageView(
                        imageUrls: imageUrls,
                      ),
                    ),
                    Gaps.v10,
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
          ),
        ),
      ),
    );
  }
}
