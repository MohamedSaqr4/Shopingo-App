import 'package:flutter/material.dart';
import 'package:ecommerce/core/styles/app_text_styles.dart';

class AuthFooter extends StatelessWidget {
  final String prefixText;
  final String actionText;
  final VoidCallback onTap;

  const AuthFooter({
    super.key,
    required this.prefixText,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          prefixText,
          style: AppTextStyles.basedgray16w400,
        ),
        TextButton(
          onPressed: onTap,
          child: Text(actionText, style: AppTextStyles.subtitle),
        ),
      ],
    );
  }
}
