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

final class DeletedOrderSuccessState extends ManagementState {}

final class DeletedOrderSuccessAgainState extends ManagementState {}

final class DeletedOrderFailureState extends ManagementState {
  final String? errMessage;
  DeletedOrderFailureState({this.errMessage});
}

final class ChangeSearchedTimeState extends ManagementState {}

final class ChangeSearchKeyState extends ManagementState {}

final class CloseSearchState extends ManagementState {}

final class LoadingGetSearchedOrderState extends ManagementState {}

final class SuccessGetSearchedOrderState extends ManagementState {}

final class FailureGetSearchedOrderState extends ManagementState {
  final String? errMessage;
  FailureGetSearchedOrderState({this.errMessage});
}
final class ChangeCategorizedState extends ManagementState {
  
  ChangeCategorizedState();
}
final class MakeOrderDeliverOrNotSuccessState extends ManagementState {
  final String ?successMessage;
  MakeOrderDeliverOrNotSuccessState({this.successMessage});
}
