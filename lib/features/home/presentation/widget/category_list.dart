import 'package:ecommerce/features/home/data/models/category_model.dart';
import 'package:ecommerce/features/home/presentation/logic/categories_cubit/categories_cubit.dart';
import 'package:ecommerce/features/home/presentation/logic/product_cubit/product_cubit.dart';
import 'package:ecommerce/features/home/presentation/widget/category.dart';
import 'package:ecommerce/features/home/presentation/widget/category_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});
  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  int? selectedId; // thats mean selectedId = null

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38.h,
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesSuccess) {
            final categories = [
              CategoryModel(id: null, name: "All"),
              ...state.categories
            ];
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return Category(
                  categoryName: category.name ?? "",
                  isSelected: selectedId == category.id,
                  onTap: () {
                    setState(() {
                      selectedId = category.id;
                    });
                    if (category.id == null) {
                      context.read<ProductsCubit>().getAllProducts();
                    } else {
                      context
                          .read<ProductsCubit>()
                          .getProductsByCategory(category.id!);
                    }
                  },
                );
              },
            );
          }
          return const CategoriesShimmer();
        },
      ),
    );
  }
}
