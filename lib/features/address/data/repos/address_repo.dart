import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/api/api_consumer.dart';
import 'package:ecommerce/core/api/api_end_points.dart';
import 'package:ecommerce/core/errors/server_exceptions.dart';
import 'package:ecommerce/features/address/data/models/address_model.dart';

class AddressRepository {
  final ApiConsumer api;
  AddressRepository(this.api);

  Future<Either<String, List<AddressModel>>> fetchAllAddresses() async {
    try {
      final response = await api.getRequest(EndPoints.addresses);
      if (response == null) {
        return const Left("No response from server");
      }
      final List<AddressModel> addresses = (response as List)
          .map((item) => AddressModel.fromJson(item))
          .toList();
      return Right(addresses);
    } on ServerException catch (e) {
      return Left(e.errorModel.messages.join(", "));
    } catch (e) {
      return Left(
          'Unexpected error in AddressRepository.fetchAllAddresses: $e');
    }
  }
}
