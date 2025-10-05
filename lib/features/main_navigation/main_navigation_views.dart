import 'package:ecommerce/core/service_locator/service_locator.dart';
import 'package:ecommerce/core/styles/app_colors.dart';
import 'package:ecommerce/features/account/presentation/view/account_view.dart';
import 'package:ecommerce/features/cart/presentation/view/cart_view.dart';
import 'package:ecommerce/features/home/data/repos/categories_repo.dart';
import 'package:ecommerce/features/home/data/repos/products_repo.dart';
import 'package:ecommerce/features/home/presentation/logic/categories_cubit/categories_cubit.dart';
import 'package:ecommerce/features/home/presentation/logic/product_cubit/product_cubit.dart';
import 'package:ecommerce/features/home/presentation/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationViews extends StatefulWidget {
  const MainNavigationViews({super.key});

  @override
  State<MainNavigationViews> createState() => _MainNavigationViewsState();
}

class _MainNavigationViewsState extends State<MainNavigationViews> {
  late PageController pageController;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  List<Widget> views = [
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoriesCubit(
            sl<CategoriesRepositry>(),
          ),
        ),
        BlocProvider(
          create: (context) => ProductsCubit(
            sl<ProductsRepository>(),
          ),
        ),
      ],
      child: const HomeView(),
    ),
    const CartView(),
    const AccountView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: views,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.blue,
        unselectedItemColor: AppColors.baseGray,
        elevation: 0.0,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });

          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house, size: 20.sp),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.cartShopping, size: 20.sp),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user, size: 20.sp),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
