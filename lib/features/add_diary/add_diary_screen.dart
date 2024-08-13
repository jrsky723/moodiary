import 'package:flutter/material.dart';
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
  DateTime _selectedDate = DateTime.now();
  int duration = 300;

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
            InfoButton(
              icon: FontAwesomeIcons.floppyDisk,
              size: Sizes.size24,
              color: Colors.grey.shade600,
              onTap: () => print("저장"),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: DiaryContainer(
                text: S.of(context).diary,
                child: const DiaryTextWidget(),
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
