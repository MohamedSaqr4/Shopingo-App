// import 'package:ecommerce/core/styles/app_text_styles.dart';
// import 'package:ecommerce/core/widgets/spacer.dart';
// import 'package:ecommerce/features/cart/presentation/widgets/price_row.dart';
// import 'package:flutter/material.dart';

// class PriceDetails extends StatefulWidget {
//   PriceDetails({super.key, required this.totalPrice});
//   late int totalPrice;

//   @override
//   State<PriceDetails> createState() => _PriceDetailsState();
// }

// class _PriceDetailsState extends State<PriceDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         PriceRow(
//           title: 'Sub-total',
//           price: '${widget.totalPrice}',
//         ),
//         const HeightSpace(16),
//         const PriceRow(
//           title: 'VAT (%)',
//           price: '0.00',
//         ),
//         const HeightSpace(16),
//         const PriceRow(
//           title: 'Shipping fee',
//           price: '30.0',
//         ),
//         const HeightSpace(16),
//         const Divider(
//           thickness: 1,
//           color: Color(0xffE6E6E6),
//         ),
//         const HeightSpace(16),
//         Row(
//           children: [
//             Text(
//               'Total',
//               style:
//                   AppTextStyles.subtitle.copyWith(fontWeight: FontWeight.w400),
//             ),
//             const Spacer(),
//             Text(
//               '${widget.totalPrice + 30} EGP',
//               style:
//                   AppTextStyles.subtitle.copyWith(fontWeight: FontWeight.w600),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
