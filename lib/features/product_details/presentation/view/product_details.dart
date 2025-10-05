import 'package:flutter/widgets.dart';
import 'package:ecommerce/core/api/api_end_points.dart';
import 'package:ecommerce/core/styles/app_colors.dart';
import 'package:ecommerce/core/styles/app_text_styles.dart';
import 'package:ecommerce/core/utils/loading_lottie_widget.dart';
import 'package:ecommerce/core/widgets/custom_button.dart';
import 'package:ecommerce/core/widgets/spacer.dart';
import 'package:ecommerce/features/home/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details',
          style: AppTextStyles.title.copyWith(fontSize: 24.sp),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.black,
            size: 24.sp,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 368.h,
                  width: double.infinity,
                  color: AppColors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product.images?.isNotEmpty == true
                          ? product.images!.first
                          : 'https://via.placeholder.com/600x400?text=No+Image',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, color: Colors.red),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: LoadingLottie());
                      },
                    ),
                  ),
                ),
                const HeightSpace(12),
                Text(
                  product.title.toString(),
                  style: AppTextStyles.title.copyWith(fontSize: 24.sp),
                ),
                const HeightSpace(13),
                Row(
                  children: [
                    Icon(Icons.star,
                        color: const Color(0xffFFA928), size: 20.sp),
                    Text(
                      '4.5/5 ',
                      style: AppTextStyles.subtitle,
                    ),
                    Text(
                      '(45 reviews)',
                      style: AppTextStyles.basedgray16w400
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const HeightSpace(13),
                Text(product.description.toString(),
                    style: AppTextStyles.basedgray16w400),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            color: AppColors.baseGray,
          ),
          Container(
            height: 105.h,
            padding: EdgeInsets.only(
                left: 24.w, right: 24.w, top: 20.h, bottom: 4.h),
            color: AppColors.white,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Price',
                        style: AppTextStyles.basedgray16w400,
                      ),
                      Text(
                        '${product.price} EGP',
                        style: AppTextStyles.title.copyWith(fontSize: 24.sp),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CustomButton(
                    width: 240.w,
                    height: 56.h,
                    text: 'Add to Cart',
                    iconBefore: Icon(Icons.shopping_bag, size: 22.sp),
                    onPressed: () async {
                      var cartBox = await Hive.openBox(EndPoints.cartBox);
                      await cartBox.put( product.id as int ,{
                         'productName': product.title.toString(),
                        'productPrice': product.price,
                        'productImage': product.images!.first,
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
