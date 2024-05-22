import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/mood.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/utils.dart';

class CommunityPost {
  final String title;
  final String ownerName;
  final String ownerImageUrl;
  final String postUrl;
  final List<String> images;

  const CommunityPost({
    required this.title,
    required this.ownerName,
    required this.ownerImageUrl,
    required this.postUrl,
    required this.images,
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
  int _selectedTabIdx = 0;
  bool _isLoading = false;
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  late List<CommunityPost> posts;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: Mood.values.length + 1, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIdx = _tabController.index;
      });
    });
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
        title: '오늘은 집에서 밥을 먹었어요!:)',
        ownerName: '홍길동',
        ownerImageUrl: 'https://source.unsplash.com/random/?programming,$index',
        postUrl: 'https://source.unsplash.com/random/?programming,$index',
        images: List.generate(
          3,
          (i) => 'https://source.unsplash.com/random/?programming,$index',
        ),
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
      print('posts: $posts');
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
              title: const Text('Community'),
              pinned: true,
              floating: true,
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.black,
              bottom: TabBar(
                controller: _tabController,
                tabs: List.generate(Mood.values.length + 1, _buildTab),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: List.generate(
            Mood.values.length + 1,
            (index) => _buildTabContent(index),
          ),
        ),
      ),
    );
  }

  Tab _buildTab(int index) {
    if (index == 0) {
      return const Tab(
        text: 'All',
      );
    } else {
      return Tab(
        icon: Icon(
          Icons.circle,
          color: Mood.values[index - 1].color,
        ),
      );
    }
  }

  Widget _buildTabContent(int index) {
    return RefreshIndicator(
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
                  backgroundImage: NetworkImage(posts[postIndex].ownerImageUrl),
                ),
                title: Text(posts[postIndex].title),
                subtitle: Text(posts[postIndex].ownerName),
                trailing: IconButton(
                  icon: const Icon(
                    FontAwesomeIcons.arrowRightToBracket,
                    color: Colors.grey,
                    size: Sizes.size20,
                  ),
                  onPressed: () {
                    // todo: open url
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  itemCount: posts[postIndex].images.length,
                  controller: PageController(),
                  itemBuilder: (context, imageIndex) {
                    return Padding(
                      padding: const EdgeInsets.all(Sizes.size16),
                      child: Container(
                        padding: const EdgeInsets.all(Sizes.size32),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border.fromBorderSide(
                            BorderSide(
                              color: Colors.black,
                              width: 0.5,
                            ),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 5,
                              offset: Offset(0, 5),
                              spreadRadius: 0.1,
                            ),
                          ],
                        ),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.network(
                            posts[postIndex].images[imageIndex],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Gaps.v32,
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
  }
}
