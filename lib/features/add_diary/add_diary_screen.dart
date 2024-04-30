import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodiary/common/widgets/p_info_button.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/add_diary/widgets/daily_list.dart';
import 'package:moodiary/features/add_diary/widgets/diary_container.dart';
import 'package:moodiary/features/add_diary/widgets/emtion_list.dart';
import 'package:moodiary/features/add_diary/widgets/image_picker_button.dart';
import 'package:moodiary/features/add_diary/widgets/people_list.dart';
import 'package:moodiary/features/add_diary/widgets/sleep_time_picker.dart';

class AddDiaryScreen extends StatefulWidget {
  const AddDiaryScreen({super.key});

  @override
  State<AddDiaryScreen> createState() => _AddDiaryScreenState();
}

class _AddDiaryScreenState extends State<AddDiaryScreen> {
  late final ScrollController _scrollController;

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  DateTime? bedtime;
  DateTime? wakeTime;

  void _pickTime({required bool isBedTime}) {
    DatePicker.showTimePicker(
      context,
      showTitleActions: true,
      onConfirm: (date) {
        setState(() {
          if (isBedTime) {
            bedtime = date;
          } else {
            wakeTime = date;
          }
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }

  void _openTimePicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("시간 선택"),
          content: SizedBox(
            height: 200, // 다이얼로그 크기 조절
            child: Column(
              children: [
                ElevatedButton(
                  child: const Text("취침 시각 선택"),
                  onPressed: () => _pickTime(isBedTime: true),
                ),
                ElevatedButton(
                  child: const Text("기상 시각 선택"),
                  onPressed: () => _pickTime(isBedTime: false),
                ),
                if (bedtime != null)
                  Text("취침 시각: ${bedtime!.hour}시 ${bedtime!.minute}분"),
                if (wakeTime != null)
                  Text("기상 시각: ${wakeTime!.hour}시 ${wakeTime!.minute}"),
              ],
            ),
          ),
        );
      },
      barrierColor: Colors.black54, // 배경 어둡게 처리
    );
  }

  @override
  void initState() {
    // TODO: implement initState
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
              size: Sizes.size24,
              color: Colors.grey.shade600,
            ),
            Row(
              children: [
                Text(
                  '4월 3일 수요일',
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
                ),
              ],
            ),
            pInfoButton(
              icon: FontAwesomeIcons.xmark,
              size: Sizes.size24,
              color: Colors.grey.shade600,
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
              child: EmotionList(
                items: emotions,
                crossAxisCount: 4,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DiaryContainer(
              text: "사람",
              child: PeopleList(
                items: people,
                crossAxisCount: 5,
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
