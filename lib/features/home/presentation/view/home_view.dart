import 'package:ecommerce/core/routes/app_routes.dart';
import 'package:ecommerce/core/styles/app_colors.dart';
import 'package:ecommerce/core/styles/app_text_styles.dart';
import 'package:ecommerce/core/widgets/custom_text_form_field.dart';
import 'package:ecommerce/core/widgets/spacer.dart';
import 'package:ecommerce/features/home/presentation/logic/categories_cubit/categories_cubit.dart';
import 'package:ecommerce/features/home/presentation/logic/product_cubit/product_cubit.dart';
import 'package:ecommerce/features/home/presentation/widget/category_list.dart';
import 'package:ecommerce/features/home/presentation/widget/product_card.dart';
import 'package:ecommerce/features/home/presentation/widget/products_shimmer_gridview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoriesCubit>().getAllCategories();
      context.read<ProductsCubit>().getAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeightSpace(50),
            Text(
              'Discover',
              style: AppTextStyles.title,
            ),
            const HeightSpace(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomTextFormField(
                  height: 52.h,
                  width: 265.w,
                  hintText: 'Search for Your...',
                ),
                const WidthSpace(12),
                Container(
                  height: 52.h,
                  width: 52.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.blue,
                  ),
                  child: const Icon(
                    FontAwesomeIcons.list,
                    size: 24,
                    color: AppColors.white,
                  ),
                )
              ],
            ),
            const HeightSpace(16),
            const CategoriesList(),
            const HeightSpace(24),
            BlocBuilder<ProductsCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const ProductsGridShimmer();
                }
                if (state is ProductSuccess) {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () =>
                          context.read<ProductsCubit>().getAllProducts(),
                      backgroundColor: AppColors.white,
                      color: AppColors.blue,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 29,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.70,
                        ),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return ProductCard(
                            productName: product.title!,
                            productPrice: product.price.toString(),
                            imageUrl: product.images?.isNotEmpty == true
                                ? product.images![0]
                                : null,
                            onTap: () => context.push(AppRoutes.productDetails,
                                extra: product),
                          )
                              .animate()
                              .fadeIn(duration: 300.ms, delay: (100 * index).ms)
                              .slideY(
                                  begin: 0.3, end: 0, curve: Curves.easeOut);
                        },
                      ),
                    ),
                  );
                } else if (state is ProductFailure) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        state.errMessage.toString(),
                        style: AppTextStyles.title,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
