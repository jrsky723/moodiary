import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodiary/common/widgets/p_info_button.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/add_diary/settings_screen.dart';
import 'package:moodiary/features/add_diary/widgets/daily_list.dart';
import 'package:moodiary/features/add_diary/widgets/diary_container.dart';
import 'package:moodiary/features/add_diary/widgets/multi_select_list.dart';
import 'package:moodiary/features/add_diary/widgets/image_picker_button.dart';
import 'package:moodiary/features/add_diary/widgets/sleep_time_picker.dart';

class AddDiaryScreen extends StatefulWidget {
  const AddDiaryScreen({super.key});

  @override
  State<AddDiaryScreen> createState() => _AddDiaryScreenState();
}

class _AddDiaryScreenState extends State<AddDiaryScreen> {
  late final ScrollController _scrollController;
  DateTime _selectedDate = DateTime.now();

  String _selectedWeekday() {
    switch (_selectedDate.weekday) {
      case 1:
        return "월요일";
      case 2:
        return "화요일";
      case 3:
        return "수요일";
      case 4:
        return "목요일";
      case 5:
        return "금요일";
      case 6:
        return "토요일";
      case 7:
        return "일요일";
      default:
        return "";
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _showDatePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('날짜선택'),
        content: SizedBox(
          // You might want to adjust the height depending on your needs or screen size
          height: 400,
          width: double.maxFinite,
          child: CalendarDatePicker(
            initialDate: _selectedDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2030),
            onDateChanged: (newDate) {
              _selectedDate = newDate;
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              setState(() {});
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            pInfoButton(
              icon: FontAwesomeIcons.gear,
              size: Sizes.size20,
              color: Colors.grey.shade600,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsScreen()));
              },
            ),
            Row(
              children: [
                Text(
                  '${_selectedDate.month}월 ${_selectedDate.day}일 ${_selectedWeekday()}',
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                pInfoButton(
                  icon: FontAwesomeIcons.caretDown,
                  size: Sizes.size16,
                  color: Colors.grey.shade900,
                  onTap: () => _showDatePickerDialog(context),
                ),
              ],
            ),
            pInfoButton(
              icon: FontAwesomeIcons.floppyDisk,
              size: Sizes.size24,
              color: Colors.grey.shade600,
              onTap: () => print("저장"),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(
            child: DiaryContainer(
              crossAxisAlignment: CrossAxisAlignment.center,
              text: "어떤 하루였나요?",
              child: DailyList(),
            ),
          ),
          SliverToBoxAdapter(
            child: DiaryContainer(
              text: "감정",
              child: MultiSelectList(
                items: emotions,
                crossAxisCount: 4,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DiaryContainer(
              text: "사람",
              child: MultiSelectList(
                items: people,
                crossAxisCount: 4,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DiaryContainer(
              text: "수면",
              child: Center(
                child: SleepDialog(
                  context: context,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DiaryContainer(
              text: "일기",
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(
                    Sizes.size5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    maxLines: 1,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "내용을 입력해주세요",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: Sizes.size14,
                      ),
                    ),
                    cursorColor: Colors.green.shade300,
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: DiaryContainer(
              text: "오늘의 사진",
              child: Center(
                child: ImagePickerButton(),
              ),
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
                child: const Text("맨 위로"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<String> emotions = [
  "신나는",
  "편안한",
  "뿌듯한",
  "기대되는",
  "행복한",
  "의욕적인",
  "설레는",
  "상쾌한",
  "우울한",
  "외로운",
  "불안한",
  "슬픈",
  "화난",
  "부담되는",
  "짜증나는",
  "피곤한",
];

List<String> people = [
  "친구",
  "가족",
  "애인",
  "지인",
  "안 만남",
];
