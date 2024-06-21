import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'controller/imagePickerController.dart';

class ImagePickerPage extends StatelessWidget {
  final ImagePickerController controller = Get.put(ImagePickerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker with GetX'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(() => controller.selectedImagePath.value == ''
                ? Text('No image selected.')
                : Image.file(File(controller.selectedImagePath.value))),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => controller.pickImage(ImageSource.camera),
              icon: Icon(Icons.camera),
              label: Text('Pick Image from Camera'),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => controller.pickImage(ImageSource.gallery),
              icon: Icon(Icons.photo_library),
              label: Text('Pick Image from Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}
