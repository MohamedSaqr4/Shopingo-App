import 'dart:io';
import 'package:ecommerce/core/service_locator/service_locator.dart';
import 'package:ecommerce/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ImagePicked extends StatefulWidget {
  const ImagePicked({super.key});

  @override
  State<ImagePicked> createState() => _ImagePickedState();
}

class _ImagePickedState extends State<ImagePicked> {
  XFile? pickedFile;
  Future<void> uploadImage() async {
    final file = await sl<ImagePicker>().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (file != null) {
      setState(() => pickedFile = file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: uploadImage,
      child: CircleAvatar(
        radius: 50.r,
        backgroundColor: AppColors.baseGray.withOpacity(0.2),
        backgroundImage:
            pickedFile != null ? FileImage(File(pickedFile!.path)) : null,
        child: pickedFile == null
            ? Icon(Icons.add_a_photo_rounded,
                size: 40.sp, color: AppColors.blue)
            : null,
      ),
    );
  }
}
