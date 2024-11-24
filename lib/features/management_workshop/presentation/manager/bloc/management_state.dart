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
final class SuccessEditOrdersState extends ManagementState {}

final class LoadingEditOrderState extends ManagementState {}

final class FailureEditOrderState extends ManagementState {
  final String? errMessage;
  FailureEditOrderState({this.errMessage});
}

final class SuccessAddNewOrderState extends ManagementState {}

final class ChangePaymentWayState extends ManagementState {}

final class ChangeCounterAmountState extends ManagementState {}

final class ChangeColorDegreeState extends ManagementState {}

final class ChangeKitchenTypeState extends ManagementState {}

final class ChangeRecieveDateState extends ManagementState {}

final class ChangeExtraListLengthState extends ManagementState {}

final class ChangeMediaPickingOrRemovingState extends ManagementState {}

final class ChangeCurrentEditableModelState extends ManagementState {
  final OrderModel model;
  ChangeCurrentEditableModelState({required this.model});
}

final class LoadingEditOrderModelState extends ManagementState {}

final class SuccessEditOrderModelState extends ManagementState {}

final class FailureEditOrderModelState extends ManagementState {
  final String? errMessage;
  FailureEditOrderModelState({this.errMessage});
}
final class LoadingDeleteOrderModelState extends ManagementState {}

final class DeletedOrderSuccessState extends ManagementState {
  
}

final class DeletedOrderSuccessAgainState extends ManagementState {}

final class DeletedOrderFailureState extends ManagementState {
  final String? errMessage;
  DeletedOrderFailureState({this.errMessage});
}
