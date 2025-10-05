import 'package:ecommerce/core/styles/app_colors.dart';
import 'package:ecommerce/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.height,
    this.width,
    this.hintText,
    this.isPassword,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.keyboardType,
    this.onFieldSubmitted,
  });
  final double? height;
  final double? width;
  final String? hintText;
  final bool? isPassword;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 341.w,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: height ?? 52.h,
        ),
        child: TextFormField(
          controller: controller,
          onFieldSubmitted: onFieldSubmitted,
          validator: validator,
          keyboardType: keyboardType,
          //style copywith is the color of text in field
          style: AppTextStyles.subtitle.copyWith(fontWeight: FontWeight.w400),
          obscureText: isPassword ?? false,
          cursorColor: AppColors.blue,
          decoration: InputDecoration(
            hintText: hintText ?? '',
            hintStyle:
                AppTextStyles.subtitle.copyWith(color: AppColors.softGray),
            suffixIcon: suffixIcon,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            filled:
                true, //taht means the field has a background color not default white and color is fill color
            fillColor: AppColors.white, //background color
            //focused border is the border after the click on the field
            enabledBorder: _customBorder(const Color(0xffE6E6E6)),
            focusedBorder: _customBorder(AppColors.blue),
            errorBorder: _customBorder(AppColors.red),
            focusedErrorBorder: _customBorder(AppColors.red),
          ),
        ),
      ),
    );
  }
}

OutlineInputBorder _customBorder(Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.r),
    borderSide: BorderSide(
      width: 1.w,
      color: color,
    ),
  );
}
