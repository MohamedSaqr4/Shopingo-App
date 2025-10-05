import 'package:flutter/material.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

class CustomSnackBar {
  static void show(
    BuildContext context,{
    required String message,
    AnimatedSnackBarType type = AnimatedSnackBarType.info,
    MobileSnackBarPosition position = MobileSnackBarPosition.bottom,
    Duration duration = const Duration(seconds: 3),
  }){
    AnimatedSnackBar.material(
      message,
      type: type,
      animationCurve: Curves.easeIn,
      mobileSnackBarPosition: position,
      duration: duration,
    ).show(context);
  }
}
