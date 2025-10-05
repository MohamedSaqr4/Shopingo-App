part of 'address_cubit.dart';

@immutable
sealed class AddressState {}

final class AddressInitial extends AddressState {}

final class AddressLoading extends AddressState {}

final class AddressSuccess extends AddressState {
  final List<AddressModel> addresses;
  AddressSuccess(this.addresses);
}

final class AddressFailure extends AddressState {
  final String message;
  AddressFailure(this.message);
}
