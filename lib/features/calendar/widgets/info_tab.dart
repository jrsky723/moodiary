import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';

class InfoTab extends StatefulWidget {
  final ImageProvider image;
  final int date;

  const InfoTab({
    super.key,
    required this.image,
    required this.date,
  });

  @override
  State<InfoTab> createState() => _InfoTapState();
}

class _InfoTapState extends State<InfoTab> {
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
              pInfoButton(icon: FontAwesomeIcons.shareNodes),
              pInfoButton(icon: FontAwesomeIcons.penToSquare),
              pInfoButton(icon: FontAwesomeIcons.trashCan),
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
              const SizedBox(
                height: Sizes.size52,
                child: VerticalDivider(
                  color: Colors.black,
                ),
              ),
              Flexible(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: const Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.babyCarriage,
                        ),
                        Gaps.h10,
                        FaIcon(
                          FontAwesomeIcons.baby,
                        ),
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

class pInfoButton extends StatelessWidget {
  final IconData icon;
  const pInfoButton({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size10,
      ),
      child: GestureDetector(
        onTap: () {},
        child: FaIcon(
          icon,
          size: Sizes.size14,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }
}

// Vertical Divider 작동 안됨 있긴한데 안보임
// gestureDetector 를 이용해서 클릭하면 reverse되어서 뒤에는 글이 앞에는 이모지 보이게 설정 
//  + text overflow되면 아이콘 만들어서 펼치기 기능 가능하도록 설정(optional)