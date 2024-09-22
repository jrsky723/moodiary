import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/calendar/models/diary_entry.dart';
import 'package:moodiary/generated/l10n.dart';
import 'package:moodiary/utils/build_utils.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<DiaryEntry> _searchResults = [];

  void _onSearchChanged(String value) {
    if (value.isEmpty) {
      _searchResults.clear();
      setState(() {});
      return;
    }
    // _searchResults = _diaryEntries.where((entry) {
    //   final title = entry.title.toLowerCase();
    //   final description = entry.description.toLowerCase();
    //   final searchValue = value.toLowerCase();
    //   return title.contains(searchValue) || description.contains(searchValue);
    // }).toList();
    _searchResults = [
      DiaryEntry(
        title: '오늘 날씨 맑음',
        description: '오늘은 집에서 하루종일 코딩만하다가 밖에 산책을 나갔는데',
        date: '2024-3-27',
        imageUrl: 'https://picsum.photos/200/300',
      ),
      DiaryEntry(
        title: '운동한 날',
        description: '오늘은 운동을 하고 나니까 기분이 좋아졌다.',
        date: '2024-3-26',
        imageUrl:
            'https://health.chosun.com/site/data/img_dir/2020/12/18/2020121801715_0.jpg',
      ),
    ];
    setState(() {});
  }

  void _onClearPressed() {
    _searchController.clear();
    _searchResults.clear();
    setState(() {});
  }

  Widget highlightSearchResult({
    required String text,
    required String searchQuery,
    required TextStyle normalStyle,
    required TextStyle highlightStyle,
  }) {
    if (searchQuery.isEmpty) {
      return Text(text);
    }
    List<TextSpan> spans = [];
    int start = 0;
    int indexOfHighlight;
    do {
      indexOfHighlight = text.indexOf(searchQuery, start);
      if (indexOfHighlight < 0) {
        // 검색어가 더 이상 없으면
        spans.add(TextSpan(
          style: normalStyle,
          text: text.substring(start),
        ));
      } else {
        if (indexOfHighlight > start) {
          spans.add(TextSpan(
            style: normalStyle,
            text: text.substring(start, indexOfHighlight),
          ));
        }
        spans.add(TextSpan(
          style: highlightStyle,
          text: searchQuery,
        ));
        start = indexOfHighlight + searchQuery.length;
      }
    } while (indexOfHighlight >= 0);

    return RichText(text: TextSpan(children: spans));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: _onSearchChanged,
          style: const TextStyle(
            decorationThickness: 0,
          ),
          cursorColor: Colors.grey,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: Sizes.size20,
              vertical: 0,
            ),
            hintText: S.of(context).diarySearchHint,
            filled: true,
            fillColor: isDark ? Colors.grey.shade800 : Colors.green.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            suffixIcon: _searchController.text.isEmpty
                ? null
                : IconButton(
                    icon: Icon(
                      FontAwesomeIcons.xmark,
                      color:
                          isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                    ),
                    onPressed: _onClearPressed,
                  ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final item = _searchResults[index];
          return ListTile(
            onTap: () {
              // Navigator.of(context).pushNamed(
              //   Routes.diaryDetail,
              //   arguments: item,
              // );
            },
            title: highlightSearchResult(
              text: item.title,
              searchQuery: _searchController.text,
              normalStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
              highlightStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: highlightSearchResult(
              text: item.description,
              searchQuery: _searchController.text,
              normalStyle: TextStyle(
                color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
              ),
              highlightStyle: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            leading: Container(
              width: Sizes.size48,
              height: Sizes.size48,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.antiAlias,
              child: item.imageUrl != null
                  ? Image.network(
                      item.imageUrl!,
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            trailing: Text(
              item.date,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          );
        },
      ),
    );
  }
}
