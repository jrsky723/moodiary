import 'package:flutter/material.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';

class CommonFormScreen extends StatelessWidget {
  final String appBarTitle;
  final String? title;
  final String? description;
  final List<Widget> children;

  const CommonFormScreen({
    super.key,
    required this.appBarTitle,
    this.title,
    this.description,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v10,
              title != null
                  ? Text(
                      title!,
                      style: const TextStyle(
                        fontSize: Sizes.size20,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : const SizedBox(),
              Gaps.v20,
              description != null
                  ? Text(
                      description!,
                      style: const TextStyle(
                        fontSize: Sizes.size16,
                        color: Colors.black54,
                      ),
                    )
                  : const SizedBox(),
              Gaps.v20,
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}
