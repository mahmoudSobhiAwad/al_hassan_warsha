part of 'management_bloc.dart';

@immutable
sealed class ManagementEvent {}

final class GetAllOrdersEvent extends ManagementEvent {}

final class AddNewOrderEvent extends ManagementEvent {}

final class ChangeOptionPaymentEvent extends ManagementEvent {
  final OptionPaymentWay paymentWay;
  ChangeOptionPaymentEvent({required this.paymentWay});
}

final class ChangeCounterOfStepsInPillEvent extends ManagementEvent {
  final bool increase;
  ChangeCounterOfStepsInPillEvent({required this.increase});
}

final class ChangeColorOfOrderEvent extends ManagementEvent {
  final int colorValue;
  ChangeColorOfOrderEvent({required this.colorValue});
}

final class ChangeDateOfOrderEvent extends ManagementEvent {
  final DateTime dateTime;
  ChangeDateOfOrderEvent({required this.dateTime});
}

final class ChangeKitchenTypeEvent extends ManagementEvent {
  final String kitchenType;
  ChangeKitchenTypeEvent({required this.kitchenType});
}

final class AddExtraInOrder extends ManagementEvent {
  AddExtraInOrder();
}
final class RemoveExtraItem extends ManagementEvent {
  final int index;
  RemoveExtraItem({required this.index});
}
final class AddMediaInAddOrder extends ManagementEvent {
  final List<String> list;
  AddMediaInAddOrder({required this.list});
}
final class RemoveMediItemEvent extends ManagementEvent {
  final int index;
  RemoveMediItemEvent({required this.index});
}
