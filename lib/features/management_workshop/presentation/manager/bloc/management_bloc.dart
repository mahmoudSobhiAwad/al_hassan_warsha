import 'dart:async';
import 'package:al_hassan_warsha/core/utils/functions/get_media_type.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/color_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/customer_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/extra_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/media_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/pill_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/repos/management_repo_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
part 'management_event.dart';
part 'management_state.dart';

class ManagementBloc extends Bloc<ManagementEvent, ManagementState> {
  final ManagementRepoImpl managementRepoImpl;
  ManagementBloc({required this.managementRepoImpl})
      : super(ManagementInitialState()) {
    on<GetAllOrdersEvent>(getAllOrders);
    on<ChangeOptionPaymentEvent>(changeOptionPayment);
    on<ChangeCounterOfStepsInPillEvent>(changeCounterOfStepsInPill);
    on<ChangeColorOfOrderEvent>(changeColor);
    on<ChangeDateOfOrderEvent>(changeDate);
    on<ChangeKitchenTypeEvent>(changeType);
    on<AddExtraInOrder>(addMoreExtra);
    on<RemoveExtraItem>(deleteMoreExtra);
    on<AddMediaInAddOrder>(addMediaInOrder);
    on<RemoveMediItemEvent>(delteMediaItem);
  }
  bool isLoadingAllOrders = true;
  List<OrderModel> ordersList = [];

  // add order
  bool isLoadingAddOrder = true;
  OrderModel orderModel = OrderModel(orderId: const Uuid().v1());
  List<PickedMedia> mediaOrderList = [];
  CustomerModel customerModel = CustomerModel(customerId: const Uuid().v8());
  PillModel pillModel = PillModel(pillId: const Uuid().v4());

  ColorOrderModel colorModel = ColorOrderModel(colorId: const Uuid().v6());
  List<ExtraInOrderModel> extraOrdersList = [];
  //

  FutureOr<void> getAllOrders(
      GetAllOrdersEvent event, Emitter<ManagementState> emit) async {
    isLoadingAllOrders = true;
    emit(LoadingGetAllOrdersState());
    final result = await managementRepoImpl.getAllOrders();
    result.fold((list) {
      ordersList.addAll(list);
      isLoadingAllOrders = false;
      emit(SuccessGetAllOrdersState());
    }, (error) {
      isLoadingAllOrders = false;
      emit(FailureGetAllOrdersState(errMessage: error));
    });
  }

  FutureOr<void> addNewOrder(
      AddNewOrderEvent event, Emitter<ManagementState> emit) async {
    emit(LoadingAddNewOrderState());
    isLoadingAddOrder = true;
    prepareOrderModelBeforeSend();
    var result = await managementRepoImpl.createNewOrder(orderModel);
    return result.fold((success) {
      isLoadingAddOrder = false;
      emit(SuccessAddNewOrderState());
    }, (error) {
      isLoadingAddOrder = false;
      emit(FailureAddNewOrderState());
    });
  }

  FutureOr<void> changeOptionPayment(
      ChangeOptionPaymentEvent event, Emitter<ManagementState> emit) async {
    pillModel.optionPaymentWay = event.paymentWay;
    emit(ChangePaymentWayState());
  }

  FutureOr<void> changeCounterOfStepsInPill(
      ChangeCounterOfStepsInPillEvent event,
      Emitter<ManagementState> emit) async {
    if (event.increase) {
      pillModel.stepsCounter++;
    } else {
      pillModel.stepsCounter > 0 ? pillModel.stepsCounter-- : 0;
    }
    emit(ChangePaymentWayState());
  }

  void prepareOrderModelBeforeSend() {
    List<MediaOrderModel> mediaList = [];
    orderModel.colorModel = colorModel;
    orderModel.customerId = customerModel.customerId;
    orderModel.customerModel = customerModel;
    orderModel.extraOrdersList = extraOrdersList;
    orderModel.mediaCounter = mediaOrderList.length;
    orderModel.pillModel = pillModel;
    for (var item in mediaOrderList) {
      mediaList.add(MediaOrderModel(
          mediaId: "",
          mediaPath: item.mediaPath,
          mediaType: item.mediaType,
          orderId: ""));
    }
    orderModel.mediaOrderList = mediaList;
  }

  FutureOr<void> changeColor(
      ChangeColorOfOrderEvent event, Emitter<ManagementState> emit) async {
    colorModel.colorDegree = event.colorValue;
    emit(ChangeColorDegreeState());
  }

  FutureOr<void> changeType(
      ChangeKitchenTypeEvent event, Emitter<ManagementState> emit) async {
    orderModel.kitchenType = event.kitchenType;
    emit(ChangeKitchenTypeState());
  }

  FutureOr<void> changeDate(
      ChangeDateOfOrderEvent event, Emitter<ManagementState> emit) async {
    orderModel.recieveTime = event.dateTime;
    emit(ChangeRecieveDateState());
  }

  FutureOr<void> addMoreExtra(
      AddExtraInOrder event, Emitter<ManagementState> emit) async {
    extraOrdersList.add(ExtraInOrderModel(extraId: "", extraName: ""));
    emit(ChangeExtraListLengthState());
  }

  FutureOr<void> deleteMoreExtra(
      RemoveExtraItem event, Emitter<ManagementState> emit) async {
    extraOrdersList.removeAt(event.index);
    emit(ChangeExtraListLengthState());
  }

  FutureOr<void> delteMediaItem(
      RemoveMediItemEvent event, Emitter<ManagementState> emit) async {
    mediaOrderList.removeAt(event.index);
    emit(ChangeMediaPickingOrRemovingState());
  }

  FutureOr<void> addMediaInOrder(
      AddMediaInAddOrder event, Emitter<ManagementState> emit) async {
    for (var item in event.list) {
      mediaOrderList.add(PickedMedia(
          mediaPath: item, mediaType: getMediaType(item), mediId: ''));
    }
    emit(ChangeMediaPickingOrRemovingState());
  }
}
