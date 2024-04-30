import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerButton extends StatefulWidget {
  const ImagePickerButton({super.key});

  @override
  _ImagePickerButtonState createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends State<ImagePickerButton> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _cancelSelection() {
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        backgroundColor: Colors.grey.shade300,
        foregroundColor: Colors.grey.shade500,
        surfaceTintColor: Colors.grey.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5), // Sizes.size5 대신에 리터럴 값 사용
        ),
      ),
      onPressed: _pickImage,
      child: _image == null
          ? Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 52), // Sizes.size52 대신에 리터럴 값 사용
                  child: Column(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.camera,
                        color: Colors.grey.shade700,
                        size: 52, // Sizes.size52 대신에 리터럴 값 사용
                      ),
                      Text(
                        "사진을 선택해주세요",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                      5), // Match the button's borderRadius
                  child: Image.file(
                    _image!,
                    fit: BoxFit
                        .contain, // This will cover the area without distorting the aspect ratio
                    height: buttonSize[
                        'height'], // Set the height to limit the size of the image
                    width: buttonSize[
                        'width'], // Width takes the full width of the button
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.red),
                  onPressed: _cancelSelection,
                ),
              ],
            ),
    );
  }
}

Map<String, double> buttonSize = {
  'height': 179,
  'width': 317.4,
};
