part of 'management_bloc.dart';

@immutable
sealed class ManagementState {}

final class ManagementInitialState extends ManagementState {}

final class LoadingGetAllOrdersState extends ManagementState {}

final class FailureGetAllOrdersState extends ManagementState {
  final String? errMessage;
  FailureGetAllOrdersState({this.errMessage});
}

final class SuccessGetAllOrdersState extends ManagementState {}

final class LoadingAddNewOrderState extends ManagementState {}

final class FailureAddNewOrderState extends ManagementState {
  final String? errMessage;
  FailureAddNewOrderState({this.errMessage});
}

final class SuccessAddNewOrderState extends ManagementState {}

final class ChangePaymentWayState extends ManagementState {}

final class ChangeCounterAmountState extends ManagementState {}

final class ChangeColorDegreeState extends ManagementState {}

final class ChangeKitchenTypeState extends ManagementState {}

final class ChangeRecieveDateState extends ManagementState {}

final class ChangeExtraListLengthState extends ManagementState {}
