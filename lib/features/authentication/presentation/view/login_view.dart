import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:ecommerce/core/routes/app_routes.dart';
import 'package:ecommerce/core/styles/app_text_styles.dart';
import 'package:ecommerce/core/utils/animated_snackbar.dart';
import 'package:ecommerce/core/utils/loading_lottie_widget.dart';
import 'package:ecommerce/core/widgets/custom_button.dart';
import 'package:ecommerce/core/widgets/custom_text_form_field.dart';
import 'package:ecommerce/core/widgets/spacer.dart';
import 'package:ecommerce/features/authentication/presentation/logic/auth_cubit.dart';
import 'package:ecommerce/features/authentication/presentation/widgets/auth_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isPassword = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              CustomSnackBar.show(context,
                  message: 'Login Success', type: AnimatedSnackBarType.success);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                context.go(AppRoutes.mainNavigationViews);
              });
            }
            if (state is AuthFailure) {
              CustomSnackBar.show(context,
                  message: state.message, type: AnimatedSnackBarType.error);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const LoadingLottie();
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeightSpace(30),
                    Text('Login to your account', style: AppTextStyles.title),
                    const HeightSpace(8),
                    Text('It’s great to see you again.',
                        style: AppTextStyles.basedgray16w400),
                    const HeightSpace(24),
                    Text('User Name', style: AppTextStyles.subtitle),
                    const HeightSpace(4),
                    CustomTextFormField(
                      hintText: 'Enter your email address',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        // Add more validation if needed
                        return null;
                      },
                    ),
                    const HeightSpace(16),
                    Text('Password', style: AppTextStyles.subtitle),
                    const HeightSpace(4),
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
                    const HeightSpace(55),
                    Align(
                      alignment: Alignment.center,
                      child: CustomButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthCubit>().login(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim());
                          }
                        },
                        text: 'Login',
                      ),
                    ),
                    const Spacer(),
                    AuthFooter(
                      prefixText: 'Don\'t have an account?',
                      actionText: 'Join',
                      onTap: () {
                        context.push(AppRoutes.register); // Example route
                      },
                    ),
                    const HeightSpace(20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
