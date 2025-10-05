import 'package:dio/dio.dart';
import 'package:ecommerce/core/api/api_consumer.dart';
import 'package:ecommerce/core/api/dio_consumer.dart';
import 'package:ecommerce/core/utils/storge_helper.dart';
import 'package:ecommerce/features/address/data/repos/address_repo.dart';
import 'package:ecommerce/features/authentication/data/repos/auth_repo.dart';
import 'package:ecommerce/features/home/data/repos/categories_repo.dart';
import 'package:ecommerce/features/home/data/repos/products_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  //  Dio client
  sl.registerLazySingleton<Dio>(() => Dio());

  //  DioConsumer (implementation)
  sl.registerLazySingleton<DioConsumer>(() => DioConsumer(dio: sl<Dio>()));

  //  ApiConsumer (abstraction)
  sl.registerLazySingleton<ApiConsumer>(() => sl<DioConsumer>());

  //  AuthRepository
  sl.registerFactory<AuthRepository>(() => AuthRepository(
        sl<ApiConsumer>(),
      ));

  sl.registerFactory<AddressRepository>(() => AddressRepository(
        sl<ApiConsumer>(),
      ));

  // CategoriesRepos
  sl.registerFactory<CategoriesRepositry>(
      () => CategoriesRepositry(api: sl<ApiConsumer>()));

//ProductsReposito
  sl.registerFactory<ProductsRepository>(
      () => ProductsRepository(api: sl<ApiConsumer>()));

//storge hlper secure storge
  sl.registerLazySingleton<StorgeHelper>(() => StorgeHelper());

// Image Picker
  sl.registerLazySingleton<ImagePicker>(() => ImagePicker());
}
