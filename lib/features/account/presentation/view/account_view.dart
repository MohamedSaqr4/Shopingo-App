import 'package:ecommerce/core/service_locator/service_locator.dart';
import 'package:ecommerce/core/styles/app_assets.dart';
import 'package:ecommerce/core/routes/app_routes.dart';
import 'package:ecommerce/core/styles/app_colors.dart';
import 'package:ecommerce/core/styles/app_text_styles.dart';
import 'package:ecommerce/core/utils/storge_helper.dart';
import 'package:ecommerce/core/widgets/custom_button.dart';
import 'package:ecommerce/core/widgets/spacer.dart';
import 'package:ecommerce/features/account/presentation/widget/account_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account',
          style: AppTextStyles.title.copyWith(fontSize: 24.sp),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Divider(
                color: const Color(0xffE6E6E6),
                endIndent: 25.w,
                indent: 25.w,
                thickness: 1.h,
              ),
              AccountItem(
                iconPath: AppAssets.box,
                title: 'My Orders',
                onTap: () {},
              ),
              Divider(
                color: const Color(0xffAAAAAA),
                thickness: 8.h,
              ),
              AccountItem(
                iconPath: AppAssets.details,
                title: 'My Details',
                onTap: () {},
              ),
              Divider(
                color: const Color(0xffE6E6E6),
                endIndent: 25.w,
                indent: 64.w,
                thickness: 1.h,
              ),
              AccountItem(
                iconPath: AppAssets.address,
                title: 'Address Book',
                onTap: () {
                  context.push(AppRoutes.address);
                },
              ),
              Divider(
                color: const Color(0xffE6E6E6),
                endIndent: 25.w,
                indent: 64.w,
                thickness: 1.h,
              ),
              AccountItem(
                iconPath: AppAssets.quistions,
                title: 'FAQs',
                onTap: () {},
              ),
              Divider(
                color: const Color(0xffE6E6E6),
                endIndent: 25.w,
                indent: 64.w,
                thickness: 1.h,
              ),
              AccountItem(
                iconPath: AppAssets.help,
                title: 'Help Center',
                onTap: () {},
              ),
              Divider(
                color: const Color(0xffE6E6E6),
                thickness: 8.h,
              ),
              const HeightSpace(175),
              InkWell(
                onTap: () => showLogoutDialog(context),
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                      vertical: 12.h, horizontal: 24.w),
                  child: Row(
                    children: [
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..scale(-1.0, 1.0),
                        child: Icon(
                          Icons.logout,
                          size: 24.sp,
                          color: AppColors.red,
                        ),
                      ),
                      const WidthSpace(16),
                      Text('Log Out',
                          style: AppTextStyles.subtitle.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.red)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

showLogoutDialog(context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: SizedBox(
          width: 341.w,
          child: Padding(
            padding: EdgeInsets.all(24.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppAssets.warning),
                const HeightSpace(12),
                Text(
                  'Logout?',
                  style: AppTextStyles.title.copyWith(fontSize: 20.sp),
                ),
                const HeightSpace(8),
                Text(
                  'Are you sure you want to logout?',
                  style: AppTextStyles.basedgray16w400,
                ),
                const HeightSpace(8),
                CustomButton(
                  text: 'Yes, Logout',
                  buttonColor: AppColors.red,
                  borderSideColor: AppColors.red,
                  height: 54.h,
                  onPressed: () {
                    context.pushReplacement(AppRoutes.login);
                    sl<StorgeHelper>().clearTokens();
                  },
                ),
                const HeightSpace(12),
                CustomButton(
                  text: 'No, Cancel',
                  buttonColor: AppColors.white,
                  borderSideColor: const Color(0xffCCCCCC),
                  textColor: AppColors.black,
                  height: 54.h,
                  onPressed: () {
                    context.pop();
                  },
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
