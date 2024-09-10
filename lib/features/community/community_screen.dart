import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/generated/l10n.dart';
import 'package:moodiary/utils/theme_utils.dart';

class CommunityPost {
  final String title;
  final DateTime date;
  final String ownerName;
  final String ownerImageUrl;
  final String postUrl;
  final String image;

  const CommunityPost({
    required this.title,
    required this.date,
    required this.ownerName,
    required this.ownerImageUrl,
    required this.postUrl,
    required this.image,
  });
}

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with SingleTickerProviderStateMixin {
  int _itemCount = 5;
  bool _isLoading = false;
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  late List<CommunityPost> posts;

  @override
  void initState() {
    super.initState();

    posts = generatePosts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading) {
        _loadMorePosts();
      }
    });
  }

  List<CommunityPost> generatePosts() {
    return List.generate(
      _itemCount,
      (index) => CommunityPost(
        title: '오늘의 일기',
        date: DateTime.now(),
        ownerName: '홍길동',
        ownerImageUrl: 'https://picsum.photos/200/300',
        postUrl: 'https://picsum.photos/200/300',
        image: 'https://picsum.photos/400/200', // 2:1 비율 이미지 URL
      ),
    );
  }

  Future<void> _loadMorePosts() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _itemCount += 5;
      posts = generatePosts();
      _isLoading = false;
    });
  }

  Future<void> _refreshPosts() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _itemCount = 5;
      posts = generatePosts();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text(S.of(context).communityTitle),
              pinned: true,
              floating: true,
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.black,
            ),
          ];
        },
        body: RefreshIndicator(
          onRefresh: _refreshPosts,
          child: ListView.builder(
            itemCount: posts.length + (_isLoading ? 1 : 0),
            itemBuilder: (context, postIndex) {
              if (postIndex == posts.length) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(posts[postIndex].ownerImageUrl),
                    ),
                    title: Text(posts[postIndex].title),
                    subtitle: Text(posts[postIndex].ownerName),
                    trailing: Text(
                      DateFormat.yMMMd().format(posts[postIndex].date),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: Sizes.size12,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(Sizes.size16),
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: Sizes.size16,
                          right: Sizes.size16,
                          top: Sizes.size16,
                          bottom: Sizes.size8,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isDarkMode(context) ? Colors.black : Colors.white,
                          border: const Border.fromBorderSide(
                            BorderSide(
                              color: Colors.black,
                              width: 0.5,
                            ),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                              spreadRadius: 0.1,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 3 / 2,
                              child: Image.network(
                                posts[postIndex].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Gaps.v10,
                            Expanded(
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      for (int i = 0; i < 3; i++)
                                        Container(
                                          height: Sizes.size28,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: isDarkMode(context)
                                                    ? Colors.white
                                                    : Colors.black,
                                                width: 0.5,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    child: Text(
                                      '오늘은 집에서 밥을 먹었어요!:) 집에 강아지가 있어서 너무 좋아요.  하루종일 집에만 있으니 기분이 좋네요. 주말이 절대로 안 끝나면 좋을 것 같아요. 하하하',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: Sizes.size16,
                                        height: 1.65,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    FaIcon(FontAwesomeIcons.heart),
                                    Gaps.h10,
                                    FaIcon(FontAwesomeIcons.comment),
                                    Gaps.h10,
                                  ],
                                ),
                                //emotion icons
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(FontAwesomeIcons.faceAngry),
                                    Gaps.h10,
                                    Icon(FontAwesomeIcons.faceDizzy),
                                    Gaps.h10,
                                    Icon(FontAwesomeIcons.faceFlushed),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
    );
  }
}
