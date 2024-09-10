import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:moodiary/common/widgets/p_info_button.dart';
import 'package:moodiary/constants/colors.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/add_diary/view_models/add_diary_view_model.dart';
import 'package:moodiary/features/add_diary/widgets/calendar.dart';
import 'package:moodiary/features/add_diary/widgets/diary_container.dart';
import 'package:moodiary/features/add_diary/widgets/diary_text_widget.dart';
import 'package:moodiary/features/add_diary/widgets/form_action_button.dart';
import 'package:moodiary/features/add_diary/widgets/image_picker_button.dart';
import 'package:moodiary/generated/l10n.dart';
import 'package:moodiary/utils.dart';

class AddDiaryScreen extends ConsumerStatefulWidget {
  static const String routeName = 'addDiary';
  static const String routeUrl = '/add-diary';

  const AddDiaryScreen({super.key});

  @override
  ConsumerState<AddDiaryScreen> createState() => _AddDiaryScreenState();
}

class _AddDiaryScreenState extends ConsumerState<AddDiaryScreen> {
  late final ScrollController _scrollController;
  late final TextEditingController _textController;
  bool _isLoading = false;
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  DateTime _selectedDate = DateTime.now();
  int duration = 300;
  final List<File> _tempImages = [];

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
                formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
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
          ),
        );
      },
    );
  }

  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _onSave() {
    ref.read(addDiaryProvider.notifier).saveDiary(
          _textController.text,
          _tempImages,
        );

    _hideKeyboard();

    // TODO: 페이지를 detail로 이동할지 아니면 calendar로 이동할지 결정
    Navigator.pop(context);
  }

  void _onCancel() {
    if (_isFocused) {
      _hideKeyboard();
    } else {
      // TODO :if 데이터가 남아있는게 있으면 물어보기
      _textController.clear();
      Navigator.pop(context);
    }
  }

  void _performAnalysis() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SliverAppBar(
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.none,
                    background: Container(
                      color: isDarkMode(context)
                          ? Colors.grey.shade900
                          : customPrimarySwatch,
                    ),
                  ),
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
                            color: isDarkMode(context)
                                ? Colors.grey.shade400
                                : Colors.black,
                            onTap: () => _showDatePickerDialog(context),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: DiaryContainer(
                    text: S.of(context).diary,
                    child: DiaryTextWidget(
                      controller: _textController,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: DiaryContainer(
                    text: S.of(context).todaysPhoto,
                    child: Center(
                      child: ImagePickerButton(
                        onImagesSelected: (images) {
                          setState(() {
                            _tempImages.addAll(images);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                //
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SwitchListTile.adaptive(
                        value: false,
                        onChanged: (value) => {},
                        title: Text(
                          S.of(context).communityBtn,
                        ),
                        subtitle: Opacity(
                          opacity: 0.5,
                          child: Text(
                            S.of(context).communityBtnSubtitle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // TODO: 분석 버튼만들어서 클릭하면
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size96,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        side: const BorderSide(
                          color: customPrimarySwatch,
                          width: 1.5,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size60,
                        ),
                        textStyle: const TextStyle(
                          fontSize: Sizes.size18,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _isLoading ? null : _performAnalysis,
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              S.of(context).analysisBtn,
                            ),
                    ),
                  ),
                ),
                // TODO: circumplex model을 활용한 이미지와 wordcloud 보여주기

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
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color:
                    isDarkMode(context) ? Colors.black12 : Colors.grey.shade100,
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size6,
                  horizontal: Sizes.size24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FormActionButton(
                      text: S.of(context).cancelBtn,
                      onPressed: _onCancel,
                    ),
                    FormActionButton(
                      text: S.of(context).saveBtn,
                      onPressed: _onSave,
                    )
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
