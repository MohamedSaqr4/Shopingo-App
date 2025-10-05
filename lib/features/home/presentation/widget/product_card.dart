// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';
import 'package:ecommerce/core/utils/loading_lottie_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ecommerce/core/styles/app_colors.dart';
import 'package:ecommerce/core/styles/app_text_styles.dart';
import 'package:ecommerce/core/widgets/spacer.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.productName,
    required this.productPrice,
    this.onTap,
    this.imageUrl,
  }) : super(key: key);

  final String productName;
  final String productPrice;
  final String? imageUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 244.h,
        width: 161.w,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
              child: Hero(
                tag: productName,
                child: Image.network(
                  imageUrl ??
                      'https://via.placeholder.com/300x200?text=No+Image',
                  height: 170.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error, color: Colors.red),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: LoadingLottie());
                  },
                ),
              ),
            ),
            const HeightSpace(8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Text(
                productName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.subtitle
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            const HeightSpace(3),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Text(
                '$productPrice EGP',
                style: AppTextStyles.basedgray16w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
