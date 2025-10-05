 import 'package:ecommerce/core/styles/app_text_styles.dart';
import 'package:ecommerce/core/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountItem extends StatelessWidget {
  const AccountItem({
    super.key,
    required this.iconPath,
    required this.title,
    required this.onTap,
  });

  final String iconPath;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 25.h),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24.w,
              height: 24.h,
            ),
            const WidthSpace(16),
            Text(title,
                style: AppTextStyles.subtitle
                    .copyWith(fontWeight: FontWeight.w400)),
            const Spacer(),
            Icon(Icons.arrow_forward_ios,
                size: 16.sp, color: const Color(0xffB3B3B3)),
          ],
        ),
      ),
    );
  }
}
