import 'package:ecommerce/core/api/api_end_points.dart';
import 'package:ecommerce/core/styles/app_colors.dart';
import 'package:ecommerce/core/styles/app_text_styles.dart';
import 'package:ecommerce/core/widgets/custom_button.dart';
import 'package:ecommerce/core/widgets/spacer.dart';
import 'package:ecommerce/features/cart/presentation/widgets/cart_item.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  int totalPrice = 0;

  void refreshCart() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var cartBox = Hive.box(EndPoints.cartBox);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: AppTextStyles.title.copyWith(fontSize: 24.sp),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: cartBox.listenable(),
          builder: (context, Box cartBox, _) {
            if (cartBox.isEmpty) {
              return Center(
                child: Text(
                  "Cart is empty",
                  style: AppTextStyles.title,
                ),
              );
            }
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cartBox.length,
                      itemBuilder: (context, index) {
                        final item = cartBox.getAt(index);
                        return CartItem(
                          onTotalChanged: (value) {
                            totalPrice += value;
                          },
                          id: item['ProductId'],
                          productName: item['ProductName'] ?? '',
                          imageUrl: item['ProductImage'] ?? '',
                          productPrice: item['ProductPrice'] ?? 0,
                          onItemRemoved: refreshCart,
                        );
                      },
                    ),
                    const HeightSpace(40),
                    CustomButton(
                      onPressed: () {},
                      text: 'Go To Checkout',
                      height: 54.h,
                      width: double.infinity,
                      iconAfter: const Icon(Icons.arrow_forward),
                    ), // PriceDetails(totalPrice: totalPrice),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
