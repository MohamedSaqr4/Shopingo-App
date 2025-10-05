import 'package:ecommerce/core/styles/app_colors.dart';
import 'package:ecommerce/core/styles/app_text_styles.dart';
import 'package:ecommerce/core/utils/loading_lottie_widget.dart';
import 'package:ecommerce/core/widgets/spacer.dart';
import 'package:ecommerce/features/address/presentation/logic/address_cubit.dart';
import 'package:ecommerce/features/address/presentation/widget/address_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressView extends StatefulWidget {
  const AddressView({super.key});

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddressCubit>().getAllAddresses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Address',
          style: AppTextStyles.title.copyWith(fontSize: 24.sp),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 24.sp,
            color: AppColors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: BlocBuilder<AddressCubit, AddressState>(
            builder: (context, state) {
              if (state is AddressLoading) {
                return const Center(child: LoadingLottie());
              } else if (state is AddressFailure) {
                return Center(
                  child: Text(
                    state.message,
                    style: AppTextStyles.title,
                  ),
                );
              } else if (state is AddressSuccess) {
                final addresses = state.addresses;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      color: const Color(0xffE6E6E6),
                      thickness: 1.h,
                    ),
                    const HeightSpace(20),
                    Text(
                      'Saved Address',
                      style: AppTextStyles.subtitle
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    const HeightSpace(14),
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: addresses.length,
                        itemBuilder: (context, index) { 
                          final address = addresses[index];
                          return Column(
                            children: [
                              AddressItem(
                                title: address.name,
                                address: address.description,
                              ),
                              const HeightSpace(12),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
