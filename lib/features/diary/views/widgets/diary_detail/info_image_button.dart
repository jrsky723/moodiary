import 'package:flutter/material.dart';
import 'package:moodiary/constants/sizes.dart';

class InfoImageButton extends StatelessWidget {
  final bool isAsset;
  final String imageUrl;

  const InfoImageButton({
    super.key,
    required this.isAsset,
    required this.imageUrl,
  });

  void _onPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SizedBox(
              width: double.infinity,
              child: isAsset
                  ? Image.asset(
                      imageUrl,
                      fit: BoxFit.fitWidth,
                    )
                  : Image.network(
                      imageUrl,
                      fit: BoxFit.fitWidth,
                    ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.size24,
      height: Sizes.size24,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: IconButton(
        padding: EdgeInsets.zero,
        color: Colors.white,
        icon: const Icon(Icons.info_outline_rounded),
        iconSize: Sizes.size20,
        onPressed: () => _onPressed(context),
      ),
    );
  }
}
