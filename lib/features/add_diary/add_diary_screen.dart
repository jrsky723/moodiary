import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:moodiary/common/widgets/p_info_button.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/add_diary/settings_screen.dart';
import 'package:moodiary/features/add_diary/widgets/daily_list.dart';
import 'package:moodiary/features/add_diary/widgets/diary_container.dart';
import 'package:moodiary/features/add_diary/widgets/multi_select_list.dart';
import 'package:moodiary/features/add_diary/widgets/image_picker_button.dart';
import 'package:moodiary/features/add_diary/widgets/sleep_time_picker.dart';
import 'package:moodiary/generated/l10n.dart';
import 'package:moodiary/utils.dart';

class AddDiaryScreen extends StatefulWidget {
  const AddDiaryScreen({super.key});

  @override
  State<AddDiaryScreen> createState() => _AddDiaryScreenState();
}

class _AddDiaryScreenState extends State<AddDiaryScreen> {
  late final ScrollController _scrollController;
  DateTime _selectedDate = DateTime.now();

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
        title: Text(
          S.of(context).selectMonthDay,
          style: TextStyle(
            color: isDarkMode(context) ? Colors.grey.shade400 : Colors.black,
          ),
        ),
        content: SizedBox(
          // You might want to adjust the height depending on your needs or screen size
          height: 200,
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
              Navigator.of(context).pop();
            },
            child: Text(S.of(context).cancelBtn),
          ),
          TextButton(
            onPressed: () {
              setState(() {});

              Navigator.of(context).pop();
            },
            child: Text(S.of(context).confirmBtn),
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
            InfoButton(
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
            InfoButton(
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
          SliverToBoxAdapter(
            child: DiaryContainer(
              crossAxisAlignment: CrossAxisAlignment.center,
              text: S.of(context).howWasYourDay,
              child: const DailyList(),
            ),
          ),
          SliverToBoxAdapter(
            child: DiaryContainer(
              text: S.of(context).emotion,
              child: MultiSelectList(
                items: emotions,
                crossAxisCount: 4,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DiaryContainer(
              text: S.of(context).person,
              child: MultiSelectList(
                items: people,
                crossAxisCount: 4,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DiaryContainer(
              text: S.of(context).sleep,
              child: Center(
                child: SleepDialog(
                  context: context,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DiaryContainer(
              text: S.of(context).diary,
              child: Container(
                decoration: BoxDecoration(
                  color: isDarkMode(context)
                      ? Colors.grey.shade500
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(
                    Sizes.size5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: S.of(context).enterContentPrompt,
                      hintStyle: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: Sizes.size14,
                      ),
                    ),
                    cursorColor: Colors.green.shade300,
                  ),
                ),
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
