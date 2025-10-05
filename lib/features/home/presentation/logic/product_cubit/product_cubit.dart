import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/home/data/models/product_model.dart';
import 'package:ecommerce/features/home/data/repos/products_repo.dart';
import 'package:meta/meta.dart';
part 'product_state.dart';

class ProductsCubit extends Cubit<ProductState> {
  final ProductsRepository repositry;
  ProductsCubit(this.repositry) : super(ProductInitial());

  Future<void> getAllProducts() async {
    emit(ProductLoading());
    final Either<String, List<ProductModel>> result =
        await repositry.fetchAllProduct();
    result.fold(
        (failureMessage) => emit(ProductFailure(errMessage: failureMessage)),
        (products) => emit(ProductSuccess(products: products)));
  }


Future<void> getProductsByCategory(int id) async {
  emit(ProductLoading());
  final Either<String, List<ProductModel>> result =
      await repositry.fetchProductBycategory(id);
  result.fold(
    (failureMessage) => emit(ProductFailure(errMessage: failureMessage)),
    (products) => emit(ProductSuccess(products: products)),
  );
}

}
