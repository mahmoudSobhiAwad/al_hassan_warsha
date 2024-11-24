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
import 'package:flutter/material.dart';
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
    on<AddNewOrderEvent>(addNewOrder);
    on<NavToEditEvent>(navToEdit);
    on<EditOrderEvent>(editCurrentOrder);
    on<DeleteOrderEvent>(deleteCurrentOrder);
   
  }
  bool isLoadingAllOrders = true;
  List<OrderModel> ordersList = [];

  // add order
  String orderId = const Uuid().v1();
  String customerId = const Uuid().v4();

  bool isLoadingAddOrder = true;
  OrderModel orderModel = OrderModel();
  List<PickedMedia> mediaOrderList = [];
  CustomerModel customerModel = CustomerModel(customerId: "");
  PillModel pillModel = PillModel(pillId: const Uuid().v4());

  ColorOrderModel colorModel = ColorOrderModel(colorId: const Uuid().v6());
  List<ExtraInOrderModel> extraOrdersList = [];
  final fromKey = GlobalKey<FormState>();
  OrderModel editableOrderModel = OrderModel();
  //
  List<String> removedMedia = [];
  List<String> removedExtra = [];
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
      ordersList.add(orderModel.copyWith());
      isLoadingAddOrder = false;
      orderId = const Uuid().v1();
      customerId = const Uuid().v4();
      orderModel = OrderModel();
      customerModel = CustomerModel(customerId: "");
      pillModel = PillModel(pillId: const Uuid().v4());
      colorModel = ColorOrderModel(colorId: const Uuid().v4());
      extraOrdersList = [];
      mediaOrderList = [];
      emit(SuccessAddNewOrderState());
    }, (error) {
      isLoadingAddOrder = false;
      emit(FailureAddNewOrderState());
    });
  }

  FutureOr<void> changeOptionPayment(
      ChangeOptionPaymentEvent event, Emitter<ManagementState> emit) async {
    if (event.isEdit) {
      editableOrderModel.pillModel!.optionPaymentWay = event.paymentWay;
    } else {
      pillModel.optionPaymentWay = event.paymentWay;
    }

    emit(ChangePaymentWayState());
  }

  FutureOr<void> changeCounterOfStepsInPill(
      ChangeCounterOfStepsInPillEvent event,
      Emitter<ManagementState> emit) async {
    if (event.increase) {
      event.isEdit
          ? editableOrderModel.pillModel!.stepsCounter++
          : pillModel.stepsCounter++;
    } else {
      event.isEdit
          ? editableOrderModel.pillModel!.stepsCounter--
          : pillModel.stepsCounter > 0
              ? pillModel.stepsCounter--
              : 0;
    }
    emit(ChangePaymentWayState());
  }

  void prepareOrderModelBeforeSend() {
    List<MediaOrderModel> mediaList = [];
    orderModel.orderId = orderId;
    orderModel.customerId = customerId;
    customerModel.customerId = customerId;
    orderModel.colorModel = colorModel;
    orderModel.customerModel = customerModel;
    orderModel.extraOrdersList = extraOrdersList;
    orderModel.mediaCounter = mediaOrderList.length;
    pillModel.customerName = customerModel.customerName ?? "";
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

  FutureOr<void> navToEdit(
      NavToEditEvent event, Emitter<ManagementState> emit) async {
    editableOrderModel = event.orderModel.copyWith();
    emit(ChangeCurrentEditableModelState(model: editableOrderModel));
  }

  FutureOr<void> changeColor(
      ChangeColorOfOrderEvent event, Emitter<ManagementState> emit) async {
    if (event.isEdit) {
      editableOrderModel.colorModel?.colorDegree = event.colorValue;
    } else {
      colorModel.colorDegree = event.colorValue;
    }

    emit(ChangeColorDegreeState());
  }

  FutureOr<void> changeType(
      ChangeKitchenTypeEvent event, Emitter<ManagementState> emit) async {
    if (event.isEdit) {
      editableOrderModel.kitchenType = event.kitchenType;
    } else {
      orderModel.kitchenType = event.kitchenType;
    }

    emit(ChangeKitchenTypeState());
  }

  FutureOr<void> changeDate(
      ChangeDateOfOrderEvent event, Emitter<ManagementState> emit) async {
    if (event.isEdit) {
      editableOrderModel.recieveTime = event.dateTime;
    } else {
      orderModel.recieveTime = event.dateTime;
    }
    emit(ChangeRecieveDateState());
  }

  FutureOr<void> addMoreExtra(
      AddExtraInOrder event, Emitter<ManagementState> emit) async {
    if (event.isEdit) {
      editableOrderModel.extraOrdersList
          .add(ExtraInOrderModel(extraId: "", extraName: ""));
    } else {
      extraOrdersList.add(ExtraInOrderModel(extraId: "", extraName: ""));
    }
    emit(ChangeExtraListLengthState());
  }

  FutureOr<void> deleteMoreExtra(
      RemoveExtraItem event, Emitter<ManagementState> emit) async {
    int index = event.index;
    if (event.isEdit) {
      removedExtra.add(editableOrderModel.extraOrdersList[index].extraId);
      editableOrderModel.extraOrdersList.removeAt(index);
    } else {
      extraOrdersList.removeAt(index);
    }

    emit(ChangeExtraListLengthState());
  }

  FutureOr<void> delteMediaItem(
      RemoveMediItemEvent event, Emitter<ManagementState> emit) async {
    int index = event.index;
    if (event.isEdit) {
      removedMedia.add(editableOrderModel.mediaOrderList[index].mediaId);
      editableOrderModel.mediaCounter--;
      editableOrderModel.mediaOrderList.removeAt(index);
    } else {
      mediaOrderList.removeAt(index);
    }

    emit(ChangeMediaPickingOrRemovingState());
  }

  FutureOr<void> addMediaInOrder(
      AddMediaInAddOrder event, Emitter<ManagementState> emit) async {
    editableOrderModel.mediaCounter++;
    for (var item in event.list) {
      if (event.isEdit) {
        editableOrderModel.mediaOrderList.add(MediaOrderModel(
            mediaId: "",
            mediaPath: item,
            mediaType: getMediaType(item),
            orderId: editableOrderModel.orderId));
      } else {
        mediaOrderList.add(PickedMedia(
            mediaPath: item, mediaType: getMediaType(item), mediId: ''));
      }
    }
    emit(ChangeMediaPickingOrRemovingState());
  }

  FutureOr<void> editCurrentOrder(
      EditOrderEvent event, Emitter<ManagementState> emit) async {
    emit(LoadingEditOrderState());
    final result = await managementRepoImpl.editCurrentOrder(
        editableOrderModel, removedMedia, removedExtra);
    result.fold((success) {
      int index = ordersList
          .indexWhere((test) => test.orderId == editableOrderModel.orderId);
      ordersList[index] = editableOrderModel;
      emit(SuccessEditOrderModelState());
    }, (error) {
      emit(FailureEditOrderModelState(errMessage: error));
    });
  }

  FutureOr<void> deleteCurrentOrder(
      DeleteOrderEvent event, Emitter<ManagementState> emit) async {
    emit(LoadingDeleteOrderModelState());
    final result = await managementRepoImpl.deleteCurrentOrder(
        event.orderId, event.mediaList);
    result.fold((success) {
      int index =
          ordersList.indexWhere((test) => test.orderId == event.orderId);
      ordersList.removeAt(index);
      emit(DeletedOrderSuccessState());
    }, (error) {
      emit(DeletedOrderFailureState(errMessage: error));
    });
  }
}
