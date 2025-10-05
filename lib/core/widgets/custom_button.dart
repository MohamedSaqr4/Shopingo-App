import 'package:ecommerce/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.text,
    this.textColor,
    this.onPressed,
    this.buttonColor,
    this.width,
    this.height,
    this.borderRadius,
    this.borderSideColor,
    this.iconBefore,
    this.iconAfter,
  });

  final String? text;
  final Color? textColor;
  final VoidCallback? onPressed;
  final Color? buttonColor;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? borderSideColor;
  final Widget? iconBefore;
  final Widget? iconAfter;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor ?? AppColors.blue,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.w,
            color: borderSideColor ?? AppColors.blue,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
        ),
        fixedSize: Size(width ?? 325.w, height ?? 50.h),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(iconBefore != null) ...[
            iconBefore!,
            SizedBox(width: 10.w),
          ],
          Text(
            text ?? '',
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              fontFamily: GoogleFonts.dmSans().fontFamily,
            ),
          ),
          if (iconAfter != null) ...[
            SizedBox(width: 10.w),
            iconAfter!,
          ],
        ],
      ),
    );
  }
}
