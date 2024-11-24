part of 'management_bloc.dart';

@immutable
sealed class ManagementEvent {}

final class GetAllOrdersEvent extends ManagementEvent {}

final class AddNewOrderEvent extends ManagementEvent {}

final class ChangeOptionPaymentEvent extends ManagementEvent {
  final OptionPaymentWay paymentWay;
  final bool isEdit;
  ChangeOptionPaymentEvent({required this.paymentWay, this.isEdit = false});
}

final class ChangeCounterOfStepsInPillEvent extends ManagementEvent {
  final bool increase;
  final bool isEdit;
  ChangeCounterOfStepsInPillEvent(
      {required this.increase, this.isEdit = false});
}

final class ChangeColorOfOrderEvent extends ManagementEvent {
  final int colorValue;
  final bool isEdit;
  ChangeColorOfOrderEvent({required this.colorValue, this.isEdit = false});
}

final class ChangeDateOfOrderEvent extends ManagementEvent {
  final DateTime dateTime;
  final bool isEdit;
  ChangeDateOfOrderEvent({required this.dateTime, this.isEdit = false});
}

final class ChangeKitchenTypeEvent extends ManagementEvent {
  final String kitchenType;
  final bool isEdit;
  ChangeKitchenTypeEvent({required this.kitchenType, this.isEdit = false});
}

final class AddExtraInOrder extends ManagementEvent {
  final bool isEdit;
  AddExtraInOrder({this.isEdit = false});
}

final class RemoveExtraItem extends ManagementEvent {
  final int index;
  final bool isEdit;

  RemoveExtraItem({required this.index, this.isEdit = false});
}

final class NavToEditEvent extends ManagementEvent {
  final OrderModel orderModel;
  NavToEditEvent({required this.orderModel});
}

final class AddMediaInAddOrder extends ManagementEvent {
  final List<String> list;
  final bool isEdit;
  AddMediaInAddOrder({required this.list, this.isEdit = false});
}

final class RemoveMediItemEvent extends ManagementEvent {
  final bool isEdit;
  final int index;
  RemoveMediItemEvent({required this.index, this.isEdit = false});
}

final class EditOrderEvent extends ManagementEvent {}

final class ChangeCurrentMonthEvent extends ManagementEvent {
  final int month;
  ChangeCurrentMonthEvent({required this.month});
}

final class ChangeCurrentYearEvent extends ManagementEvent {
  final int year;
  ChangeCurrentYearEvent({required this.year});
}

final class DeleteOrderEvent extends ManagementEvent {
  final List<MediaOrderModel> mediaList;
  final String orderId;
  DeleteOrderEvent({required this.mediaList, required this.orderId});
}

final class ChangeSearchKeyEvent extends ManagementEvent {
  final SearchModel searchKey;
  ChangeSearchKeyEvent({required this.searchKey});
}

final class SearchForOrderEvent extends ManagementEvent {
  final bool enable;
  SearchForOrderEvent({required this.enable});
}

final class ChangeCategrizedListEvent extends ManagementEvent {
  final int index;
  ChangeCategrizedListEvent({required this.index});
}

final class MarkOrderAsDelievredEvent extends ManagementEvent {
  final String orderId;
  final bool makeItDone;
  MarkOrderAsDelievredEvent({required this.orderId,required this.makeItDone});
}
