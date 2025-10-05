import 'package:flutter/widgets.dart';
import 'package:ecommerce/core/api/api_end_points.dart';
import 'package:ecommerce/core/styles/app_colors.dart';
import 'package:ecommerce/core/styles/app_text_styles.dart';
import 'package:ecommerce/core/utils/loading_lottie_widget.dart';
import 'package:ecommerce/core/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';

class CartItem extends StatefulWidget {
  const CartItem({
    super.key,
    required this.productName,
    required this.imageUrl,
    required this.productPrice,
    required this.onTotalChanged,
    required this.id,
    this.onItemRemoved,
  });

  final String productName;
  final String? imageUrl;
  final int productPrice;
  final int? id;
  final ValueChanged<int> onTotalChanged;
  final VoidCallback? onItemRemoved;
  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int quantity = 1;
  late int totalPrice;
  bool isRemoving = false;

  @override
  void initState() {
    super.initState();
    totalPrice = quantity * widget.productPrice;
    widget.onTotalChanged(totalPrice);
  }

  void increaseQuantity() {
    setState(() {
      quantity++;
      totalPrice = quantity * widget.productPrice;
      widget.onTotalChanged(totalPrice);
    });
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        totalPrice = quantity * widget.productPrice;
        widget.onTotalChanged(totalPrice);
      });
    }
  }

  Future<void> removeItem() async {
    setState(() => isRemoving = true);
    await Future.delayed(400.ms);
    var cartBox = Hive.box(EndPoints.cartBox);
    await cartBox.delete(widget.id);
    widget.onItemRemoved?.call();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: 400.ms,
      curve: Curves.easeIn,
      child: isRemoving
          ? const SizedBox.shrink()
          : Container(
              height: 107.h,
              width: double.infinity,
              padding: EdgeInsets.all(14.sp),
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(width: 1.sp, color: const Color(0xffE6E6E6)),
              ),
              child: Row(
                children: [
                  Container(
                    height: 79.h,
                    width: 83.w,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.imageUrl ?? 'https://via.placeholder.com/150',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stack) => const Icon(Icons.error, color: Colors.red),
                        loadingBuilder: (context, child, loading) {
                          if (loading == null) return child;
                          return const Center(child: LoadingLottie());
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.productName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.title
                                    .copyWith(fontSize: 14.sp),
                              ),
                            ),
                            InkWell(
                              onTap: removeItem,
                              child: Icon(
                                Icons.delete_rounded,
                                size: 16.sp,
                                color: AppColors.red,
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              '$totalPrice EGP',
                              style:
                                  AppTextStyles.title.copyWith(fontSize: 14.sp),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: decreaseQuantity,
                              child: Container(
                                height: 24.h,
                                width: 24.w,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(4.r),
                                  border: Border.all(
                                      width: 1.sp,
                                      color: const Color(0xffCCCCCC)),
                                ),
                                child: Icon(
                                  FontAwesomeIcons.minus,
                                  size: 12.sp,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                            const WidthSpace(9),
                            Text(
                              '$quantity',
                              style:
                                  AppTextStyles.title.copyWith(fontSize: 14.sp),
                            ),
                            const WidthSpace(9),
                            InkWell(
                              onTap: increaseQuantity,
                              child: Container(
                                height: 24.h,
                                width: 24.w,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(4.r),
                                  border: Border.all(
                                      width: 1.sp,
                                      color: const Color(0xffCCCCCC)),
                                ),
                                child: Icon(
                                  FontAwesomeIcons.plus,
                                  size: 12.sp,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
              .animate(
                target: isRemoving ? 1 : 0,
              )
              .fadeOut(duration: 400.ms)
              .slideY(begin: 0, end: -0.2, duration: 400.ms),
    );
  }
}
