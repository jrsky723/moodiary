import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/generated/l10n.dart';
import 'package:moodiary/utils.dart';

class ImagePickerButton extends StatefulWidget {
  const ImagePickerButton({super.key});

  @override
  State<ImagePickerButton> createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends State<ImagePickerButton> {
  List<File> _images = [];

  Future<void> _pickImages() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    setState(() {
      _images = pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
    });
  }

  void _cancelSelection(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 1,
          backgroundColor:
              isDarkMode(context) ? Colors.grey.shade500 : Colors.grey.shade300,
          foregroundColor: Colors.grey.shade500,
          surfaceTintColor: Colors.grey.shade100,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(Sizes.size5), // Sizes.size5 대신에 리터럴 값 사용
          ),
        ),
        onPressed: _pickImages,
        child: _images.isEmpty
            ? SizedBox(
                width: buttonSize['width'],
                height: buttonSize['height'],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Sizes.size52,
                      ),
                      child: Column(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.camera,
                            color: Colors.grey.shade700,
                            size: Sizes.size52,
                          ),
                          Text(
                            S.of(context).selectPhotoPrompt,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            Sizes.size5), // Match the button's borderRadius
                        child: Image.file(
                          _images[index],
                          fit: BoxFit
                              .cover, // This will cover the area without distorting the aspect ratio
                          height: double.infinity,
                          width: double.infinity,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.grey,
                        ),
                        onPressed: () => _cancelSelection(index),
                      ),
                    ],
                  );
                },
              ));
  }
}

Map<String, double> buttonSize = {
  'height': 179,
  'width': 317.4,
};
