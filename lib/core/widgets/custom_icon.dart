import 'package:ecommerce/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIcon extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final VoidCallback? onPressed;
  final double? size;

  const CustomIcon({
    Key? key,
    required this.icon,
    this.iconColor,
    this.onPressed,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      width: 48.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 1, color: const Color(0xffE3E9ED)),
      ),
      child: IconButton(
        onPressed: onPressed ?? () {},
        icon: Icon(
          icon,
          color: iconColor ?? AppColors.black,
          size: size ?? 20.sp,
        ),
      ),
    );
  }
}
