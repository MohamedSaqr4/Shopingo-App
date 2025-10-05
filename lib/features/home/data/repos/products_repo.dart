import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/api/api_consumer.dart';
import 'package:ecommerce/core/api/api_end_points.dart';
import 'package:ecommerce/core/errors/server_exceptions.dart';
import 'package:ecommerce/features/home/data/models/product_model.dart';

class ProductsRepository {
  final ApiConsumer api;
  ProductsRepository({required this.api});

  Future<Either<String, List<ProductModel>>> fetchAllProduct() async {
    try {
      final response = await api.getRequest(EndPoints.products);
      if (response == null) {
        return const Left("No response from server");
      }
      List<ProductModel> products = [];
      for (var item in response) {
        products.add(ProductModel.fromJson(item));
      }
      return right(products);
    } on ServerException catch (e) {
      return Left(e.errorModel.messages.join(", "));
    } catch (e) {
      return Left('Unexpected error in fetch prodct: $e');
    }
  }

  Future<Either<String, List<ProductModel>>> fetchProductBycategory(
      int id) async {
    try {
      final response = await api
          .getRequest("${EndPoints.categories}/$id/${EndPoints.products}");
      if (response == null) {
        return const Left("No response from server");
      }
      List<ProductModel> products = [];
      for (var item in response) {
        products.add(ProductModel.fromJson(item));
      }
      return right(products);
    } on ServerException catch (e) {
      return Left(e.errorModel.messages.join(", "));
    } catch (e) {
      return Left('Unexpected error in fetch product: $e');
    }
  }
}
