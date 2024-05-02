import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodiary/common/widgets/p_info_button.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';

class InfoContainer extends StatefulWidget {
  final ImageProvider image;
  final int date;

  const InfoContainer({
    super.key,
    required this.image,
    required this.date,
  });

  @override
  State<InfoContainer> createState() => _InfoTapState();
}

class _InfoTapState extends State<InfoContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.size14,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InfoButton(icon: FontAwesomeIcons.shareNodes),
              InfoButton(icon: FontAwesomeIcons.penToSquare),
              InfoButton(icon: FontAwesomeIcons.trashCan),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(
            Sizes.size10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              Sizes.size10,
            ),
            color: Colors.grey.shade100,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.9),
                blurRadius: Sizes.size1,
                offset: const Offset(0, 1),
              )
            ],
          ),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.size14),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: Sizes.size18,
                        backgroundImage: widget.image,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: Sizes.size7,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Sizes.size5,
                          ),
                          color: Colors.grey.shade300,
                        ),
                        child: Text(
                          widget.date > 9
                              ? '${widget.date} 일'
                              : '0${widget.date} 일',
                          style: TextStyle(
                            fontSize: Sizes.size12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Sizes.size52,
                child: VerticalDivider(
                  color: Colors.grey.shade600,
                ),
              ),
              Flexible(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey.shade300,
                              radius: 12,
                            ),
                            Gaps.h5,
                            CircleAvatar(
                              backgroundColor: Colors.grey.shade300,
                              radius: 12,
                            ),
                          ],
                        ),
                        Gaps.v5,
                        const Text("오늘 날씨는 굉장히 화창하고 좋았습니다."),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
