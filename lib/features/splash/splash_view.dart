import 'package:ecommerce/core/routes/app_routes.dart';
import 'package:ecommerce/core/service_locator/service_locator.dart';
import 'package:ecommerce/core/styles/app_assets.dart';
import 'package:ecommerce/core/styles/app_text_styles.dart';
import 'package:ecommerce/core/utils/storge_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2, milliseconds: 200), () async {
      final token = await sl<StorgeHelper>().getAccessToken();
      if (!mounted) {
        return; // if we are not in screen return ;thats mean dont complete code
      }
      if (token != null) {
        context.pushReplacement(AppRoutes.mainNavigationViews);
      } else {
        context.pushReplacement(AppRoutes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(AppAssets.loggo, animate: true),
            Text(
              'let\'s buy your product',
              style: AppTextStyles.title
                  .copyWith(color: const Color.fromARGB(255, 33, 82, 172)),
            ).animate().fade(delay: 400.ms).slide(
                begin: const Offset(-1, 0), end: Offset.zero, duration: 800.ms)
          ],
        ),
      ),
    );
  }
}
