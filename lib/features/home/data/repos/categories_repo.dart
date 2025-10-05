import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/api/api_consumer.dart';
import 'package:ecommerce/core/api/api_end_points.dart';
import 'package:ecommerce/core/errors/server_exceptions.dart';
import 'package:ecommerce/features/home/data/models/category_model.dart';

class CategoriesRepositry {
  final ApiConsumer api;
  CategoriesRepositry({required this.api});

  Future<Either<String, List<CategoryModel>>> fetchAllCategory() async {
    try {
      final response = await api.getRequest(EndPoints.categories);
      if (response == null) {
        return const Left("No response from server");
      }
      List<CategoryModel> categories = [];
      for (var item in response) {
        categories.add(CategoryModel.fromJson(item));
      }
      return right(categories);
    } on ServerException catch (e) {
      return Left(e.errorModel.messages.join(", "));
    } catch (e) {
      return Left('Unexpected error in AuthRepository.login: $e');
    }
  }
}
