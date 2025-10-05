import 'package:ecommerce/core/styles/app_assets.dart';
import 'package:ecommerce/core/styles/app_colors.dart';
import 'package:ecommerce/core/styles/app_text_styles.dart';
import 'package:ecommerce/core/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({super.key, required this.title, required this.address});
final String title;
final String address;



  @override
  Widget build(BuildContext context) {
    return Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 14.h, horizontal: 39.w),
                  height: 76.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border:
                        Border.all(color: const Color(0xffE6E6E6), width: 1.w),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        AppAssets.location,
                        height: 24.w,
                        width: 24.w,
                      ),
                      const WidthSpace(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style:
                                  AppTextStyles.title.copyWith(fontSize: 14.sp),
                            ),
                            Text(
                              address,
                              style: AppTextStyles.basedgray16w400
                                  .copyWith(fontSize: 14.sp),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
             ;
  }
}