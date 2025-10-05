import 'package:ecommerce/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class PriceRow extends StatelessWidget {
  const PriceRow({
    super.key,
    this.title,
    this.price,
  });
  final String? title;
  final String? price;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title ?? '',
          style: AppTextStyles.basedgray16w400,
        ),
        const Spacer(),
        Text(
          '${price ?? ''} EGP',
          style: AppTextStyles.subtitle,
        ),
      ],
    );
  }
}
