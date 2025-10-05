import 'package:ecommerce/core/routes/app_routes.dart';
import 'package:ecommerce/core/service_locator/service_locator.dart';
import 'package:ecommerce/features/address/data/repos/address_repo.dart';
import 'package:ecommerce/features/address/presentation/logic/address_cubit.dart';
import 'package:ecommerce/features/address/presentation/view/address_view.dart';
import 'package:ecommerce/features/authentication/data/repos/auth_repo.dart';
import 'package:ecommerce/features/authentication/presentation/logic/auth_cubit.dart';
import 'package:ecommerce/features/authentication/presentation/view/login_view.dart';
import 'package:ecommerce/features/authentication/presentation/view/register_view.dart';
import 'package:ecommerce/features/home/data/models/product_model.dart';
import 'package:ecommerce/features/main_navigation/main_navigation_views.dart';
import 'package:ecommerce/features/product_details/presentation/view/product_details.dart';
import 'package:ecommerce/features/splash/splash_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => BlocProvider(
        create: (context) => AuthCubit(sl<AuthRepository>()),
        child: const LoginView(),
      ),
      pageBuilder: GoTransitions.slide.toRight.withFade,
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => BlocProvider(
        create: (context) => AuthCubit(sl<AuthRepository>()),
        child: const RegisterView(),
      ),
      pageBuilder: GoTransitions.slide.toRight.withFade,
    ),
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashView(),
      pageBuilder: GoTransitions.slide.toRight.withFade,
    ),
    GoRoute(
      path: AppRoutes.mainNavigationViews,
      builder: (context, state) => const MainNavigationViews(),
      pageBuilder: GoTransitions.slide.toRight.withFade,
    ),
    GoRoute(
      path: AppRoutes.productDetails,
      builder: (context, state) {
        final product = state.extra as ProductModel;
        return ProductDetailsView(product: product);
      },
      pageBuilder: GoTransitions.fadeUpwards,
    ),
    GoRoute(
      path: AppRoutes.address,
      builder: (context, state) => BlocProvider(
        create: (context) => AddressCubit(sl<AddressRepository>()),
        child: const AddressView(),
      ),
      pageBuilder: GoTransitions.slide.toRight.withFade,
    )
  ],
);
