import 'package:ecommerce/core/styles/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingLottie extends StatelessWidget {
  const LoadingLottie({super.key, this.height, this.width});
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      AppAssets.loading,
    );
  }
}
