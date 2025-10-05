import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:ecommerce/core/styles/app_text_styles.dart';
import 'package:ecommerce/core/utils/animated_snackbar.dart';
import 'package:ecommerce/core/utils/loading_lottie_widget.dart';
import 'package:ecommerce/core/widgets/custom_button.dart';
import 'package:ecommerce/core/widgets/custom_text_form_field.dart';
import 'package:ecommerce/core/widgets/spacer.dart';
import 'package:ecommerce/features/authentication/presentation/logic/auth_cubit.dart';
import 'package:ecommerce/features/authentication/presentation/widgets/auth_footer.dart';
import 'package:ecommerce/features/authentication/presentation/widgets/image_picked.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool isPassword = true;
  final formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            CustomSnackBar.show(context,
                message: 'Registe Success let\'s login',
                type: AnimatedSnackBarType.success);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              context.pop();
            });
          }
          if (state is AuthFailure) {
            CustomSnackBar.show(context,
                message: state.message.toString(),
                type: AnimatedSnackBarType.error);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const LoadingLottie();
          }
          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeightSpace(30),
                      Text(
                        'Create an account',
                        style: AppTextStyles.title,
                      ),
                      const HeightSpace(8),
                      Text(
                        'Let’s create your account.',
                        style: AppTextStyles.basedgray16w400,
                      ),
                      const HeightSpace(24),
                      Text('Upload Image', style: AppTextStyles.subtitle),
                      const Align(
                        alignment: Alignment.center,
                        child: ImagePicked(),
                      ),
                      const HeightSpace(24),
                      Text('Full Name', style: AppTextStyles.subtitle),
                      CustomTextFormField(
                        hintText: 'Enter your full name',
                        controller: fullNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      const HeightSpace(16),
                      Text('Email', style: AppTextStyles.subtitle),
                      const HeightSpace(4),
                      CustomTextFormField(
                        hintText: 'Enter your email address',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const HeightSpace(16),
                      Text('Password', style: AppTextStyles.subtitle),
                      CustomTextFormField(
                        hintText: 'Enter your password',
                        isPassword: isPassword,
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          splashRadius: 20,
                          onPressed: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                          icon: isPassword
                              ? const Icon(
                                  Icons.visibility_off_outlined,
                                )
                              : const Icon(Icons.visibility_outlined),
                        ),
                      ),
                      const HeightSpace(16),
                      Text('Confirm Password', style: AppTextStyles.subtitle),
                      const HeightSpace(4),
                      CustomTextFormField(
                        hintText: 'Enter your password',
                        isPassword: isPassword,
                        controller: confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          } else if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          splashRadius: 20,
                          onPressed: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                          icon: isPassword
                              ? const Icon(Icons.visibility_off_outlined)
                              : const Icon(Icons.visibility_outlined),
                        ),
                      ),
                      const HeightSpace(46),
                      Align(
                        alignment: Alignment.center,
                        child: CustomButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthCubit>().register(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: fullNameController.text,
                                    avatar:
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2bUIN_lGamRjHfe8-4VTUzCppEf5q3t8Wvg&s',
                                  );
                            }
                          },
                          text: 'Create Account',
                        ),
                      ),
                      const HeightSpace(30),
                      AuthFooter(
                          prefixText: 'Already have an account?',
                          actionText: 'Login Now',
                          onTap: () {
                            context.pop();
                          }),
                      const HeightSpace(20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
