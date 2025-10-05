import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/address/data/models/address_model.dart';
import 'package:ecommerce/features/address/data/repos/address_repo.dart';
import 'package:meta/meta.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final AddressRepository repository;
  AddressCubit(this.repository) : super(AddressInitial());

  Future<void> getAllAddresses() async {
    emit(AddressLoading());
    final Either<String, List<AddressModel>> result =
        await repository.fetchAllAddresses();
    result.fold(
      (failureMessage) => emit(AddressFailure(failureMessage)),
      (addresses) => emit(AddressSuccess(addresses)),
    );
  }
}
