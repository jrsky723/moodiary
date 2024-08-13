import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:moodiary/common/widgets/p_info_button.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/add_diary/widgets/calendar.dart';
import 'package:moodiary/features/add_diary/widgets/diary_container.dart';
import 'package:moodiary/features/add_diary/widgets/diary_text_widget.dart';
import 'package:moodiary/features/add_diary/widgets/image_picker_button.dart';
import 'package:moodiary/generated/l10n.dart';
import 'package:moodiary/utils.dart';

class AddDiaryScreen extends StatefulWidget {
  static const String routeName = 'addDiary';
  static const String routeUrl = '/add-diary';

  const AddDiaryScreen({super.key});

  @override
  State<AddDiaryScreen> createState() => _AddDiaryScreenState();
}

class _AddDiaryScreenState extends State<AddDiaryScreen> {
  late final ScrollController _scrollController;
  late final TextEditingController _textController;

  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  DateTime _selectedDate = DateTime.now();
  int duration = 300;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _textController = TextEditingController();

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection !=
          ScrollDirection.idle) {
        _hideKeyboard();
      }
    });
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: duration),
      curve: Curves.easeInOut,
    );
  }

  void _showDatePickerDialog(BuildContext context) {
    late String formattedDate;

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(S.of(context).selectDate),
              content: CalendarWidget(
                initialDate: _selectedDate,
                onDateSelected: (selectedDate) {
                  setState(() {
                    _selectedDate = selectedDate;
                    formattedDate =
                        DateFormat('yyyy-MM-dd').format(_selectedDate);
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        S.of(context).selectedDate(formattedDate),
                      ),
                      backgroundColor: Colors.grey.shade700,
                    ),
                  );
                },
              ));
        });
  }

  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _onSave() {
    // TODO: 저장 로직 추가
    _hideKeyboard();
  }

  void _onCancel() {
    // TODO : 한번더 물어보는 로직 추가

    // 취소버튼 더 누르면 calendar 화면으로 이동(뒤로가기)
    // 아니면 화면 그대로

    _textController.clear();
    _hideKeyboard();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Row(
              children: [
                Text(
                  DateFormat.MMMMEEEEd().format(_selectedDate),
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    color: isDarkMode(context)
                        ? Colors.grey.shade400
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InfoButton(
                  icon: FontAwesomeIcons.caretDown,
                  size: Sizes.size16,
                  color:
                      isDarkMode(context) ? Colors.grey.shade400 : Colors.black,
                  onTap: () => _showDatePickerDialog(context),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          _hideKeyboard();
        },
        child: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: DiaryContainer(
                    text: S.of(context).diary,
                    child: DiaryTextWidget(
                      controller: _textController,
                      focusNode: _focusNode,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: DiaryContainer(
                    text: S.of(context).todaysPhoto,
                    child: const Center(
                      child: ImagePickerButton(),
                    ),
                  ),
                ),
                // TODO MVVM모델로 변경
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SwitchListTile.adaptive(
                        title: const Text(
                          '커뮤니티',
                        ),
                        subtitle: const Opacity(
                          opacity: 0.5,
                          child: Text(
                            '커뮤니티에 올리기',
                          ),
                        ),
                        value: true,
                        onChanged: (value) => false,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size20,
                      vertical: Sizes.size10,
                    ),
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () => _scrollToTop(),
                      child: Text(S.of(context).scrollToTop),
                    ),
                  ),
                ),

                // TODO: 분석 버튼만들어서 클릭하면
                // TODO: circumplex model을 활용한 이미지와 wordcloud 보여주기
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.grey.shade100,
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size6,
                  horizontal: Sizes.size24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size60,
                        ),
                        textStyle: const TextStyle(
                          fontSize: Sizes.size18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: _onCancel,
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size60,
                        ),
                        textStyle: const TextStyle(
                          fontSize: Sizes.size18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: _onSave,
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// List<String> emotions = [
//   "신나는",
//   "편안한",
//   "뿌듯한",
//   "기대되는",
//   "행복한",
//   "의욕적인",
//   "설레는",
//   "상쾌한",
//   "우울한",
//   "외로운",
//   "불안한",
//   "슬픈",
//   "화난",
//   "부담되는",
//   "짜증나는",
//   "피곤한",
// ];

// List<String> people = [
//   "친구",
//   "가족",
//   "애인",
//   "지인",
//   "안 만남",
// ];
