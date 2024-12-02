import 'dart:async';
import 'dart:developer';
import 'package:al_hassan_warsha/core/utils/functions/conver_en_to_ar.dart';
import 'package:al_hassan_warsha/core/utils/functions/get_media_type.dart';
import 'package:al_hassan_warsha/core/utils/functions/temp_crud_operation.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/color_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';
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
    on<ChangeRemainInAddOrderEvent>(changeRemianInAddOrder);
    on<AddMediaInAddOrder>(addMediaInOrder);
    on<RemoveMediItemEvent>(delteMediaItem);
    on<AddNewOrderEvent>(addNewOrder);
    on<NavToEditEvent>(navToEdit);
    on<EditOrderEvent>(editCurrentOrder);
    on<DeleteOrderEvent>(deleteCurrentOrder);
    on<ChangeCurrentMonthEvent>(changeCurrentMonth);
    on<ChangeCurrentYearEvent>(changeCurrentYear);
    on<ChangeSearchKeyEvent>(changeSearchKey);
    on<SearchForOrderEvent>(searchForOrder);
    on<ChangeCategrizedListEvent>(categorizeList);
    on<MarkOrderAsDelievredEvent>(markOrderAsDoneOrNotDone);
    on<GetAllKitchenTypesEvent>(getAllKitchenTypes);
    on<GetCustomerProfileEvent>(getCustomerProfileDate);
    on<ChangeCurrPageEvent>(changeCurrPage);
    on<StepDownMoneyEvent>(stepDownMoney);
  }
  // get all order
  bool isLoadingAllOrders = true;
  List<OrderModel> ordersList = [];
  List<String> allKitchenTypes = [];
  //

  //filter
  List<OrderModel> categorizedList = [];
  SearchModel searchKey = SearchModel(valueArSearh: '', valueEnSearh: '');
  String searchKeyWord = '';
  int currIndex = 0;
  List<OrderModel> searchList = [];
  bool enableSearchMode = false;
  int currentYear = DateTime.now().year;
  int currentMonth = DateTime.now().month;
  bool isSearchLoading = true;
  // add order
  String orderId = const Uuid().v1();
  String customerId = const Uuid().v4();
  bool isLoadingActionsOrder = false;
  OrderModel orderModel = OrderModel();
  List<PickedMedia> mediaOrderList = [];
  CustomerModel customerModel = CustomerModel(customerId: "");
  PillModel pillModel = PillModel(pillId: const Uuid().v4());

  ColorOrderModel colorModel = ColorOrderModel(colorId: const Uuid().v6());
  List<ExtraInOrderModel> extraOrdersList = [];
  final fromKey = GlobalKey<FormState>();
  //

//customer profile view
  int currPage = 0;
  bool isLoadingGetUserInfo = false;
  bool isLoadingStepPill = false;
  PageController pageController = PageController();
  @override
  Future<void> close() async {
    await TempCrudOperation.closeDb();
    return super.close(); // Ensure the parent close method is called
  }

  FutureOr<void> getCustomerProfileDate(
      GetCustomerProfileEvent event, Emitter<ManagementState> emit) async {
    isLoadingGetUserInfo = true;
    currPage = 0;
    emit(LoadingGetCustomerProfileState());
    final result =
        await managementRepoImpl.getAllCustomerInfo(event.customerId);
    return result.fold((customerProfile) {
      isLoadingGetUserInfo = false;
      emit(SuccessGetCustomerProfileState(customerModel: customerProfile));
    }, (error) {
      isLoadingGetUserInfo = false;
      emit(FailureGetCustomerProfileState(errMessage: error));
    });
  }

  FutureOr<void> changeCurrPage(
      ChangeCurrPageEvent event, Emitter<ManagementState> emit) async {
    if (event.isForward) {
      currPage++;
    } else {
      currPage--;
    }
    emit(ChangeCurrPageState());
  }

  FutureOr<void> stepDownMoney(
      StepDownMoneyEvent event, Emitter<ManagementState> emit) async {
    isLoadingStepPill = true;
    PillModel steppedPill = event.pillModel;
    BigInt steppedAmount =
        BigInt.parse(convertToEnglishNumbers(steppedPill.steppedAmount));
    steppedPill.payedAmount =
        (steppedAmount + BigInt.parse(steppedPill.payedAmount)).toString();
    BigInt remainAmount = BigInt.parse(steppedPill.remian);
    if (steppedAmount > remainAmount) {
      emit(
          FailureStepDownMoneyState(errMessage: "هذا المبلغ اكبر من المتبقي "));
    } else {
      final result = await managementRepoImpl.stepDownFromOrder(steppedPill);
      result.fold((newPillModel) {
        isLoadingStepPill = false;
        emit(SuccessStepDownMoneyState(pillModel: newPillModel));
        int index = ordersList
            .indexWhere((test) => test.orderId == newPillModel.orderId);
        ordersList[index].pillModel = newPillModel;
        int catIndex = categorizedList
            .indexWhere((test) => test.orderId == newPillModel.orderId);
        categorizedList[catIndex].pillModel = newPillModel;
      }, (error) {
        isLoadingStepPill = false;
        emit(FailureStepDownMoneyState());
      });
    }
  }

  //Edit order
  List<String> removedMedia = [];
  List<String> removedExtra = [];
  OrderModel editableOrderModel = OrderModel();
  //
  FutureOr<void> getAllKitchenTypes(
      GetAllKitchenTypesEvent event, Emitter<ManagementState> emit) async {
    emit(LoadingGetAllKitchenTypesState());
    final result = await managementRepoImpl.getAllKitchenTypes();
    result.fold((types) {
      allKitchenTypes.addAll(types);
      emit(SuccessGetAllKitchenTypesState());
    }, (error) {
      emit(FailureGetAllKitchenTypesState(errMessage: error));
    });
  }

  // functions
  FutureOr<void> getAllOrders(
      GetAllOrdersEvent event, Emitter<ManagementState> emit) async {
    ordersList.clear();
    categorizedList.clear();
    isLoadingAllOrders = true;
    emit(LoadingGetAllOrdersState());
    final result = await managementRepoImpl.getAllOrders(
        month: currentMonth, year: currentYear);
    result.fold((list) {
      ordersList.addAll(list);
      categorizedList.addAll(list);
      isLoadingAllOrders = false;
      emit(SuccessGetAllOrdersState());
    }, (error) {
      isLoadingAllOrders = false;
      emit(FailureGetAllOrdersState(errMessage: error));
    });
  }

  FutureOr<void> addNewOrder(
      AddNewOrderEvent event, Emitter<ManagementState> emit) async {
    if (!isLoadingActionsOrder) {
      emit(LoadingAddNewOrderState());
      isLoadingActionsOrder = true;
      await addNewKitchenType(emit);
      prepareOrderModelBeforeSend();
      event.customerModel != null
          ? updateOrderModel(event.customerModel!)
          : null;
      var result = await managementRepoImpl.createNewOrder(orderModel,
          forTheSameCustomer: event.customerModel != null);
      return result.fold((success) {
        orderModel.orderStatus = getOrderStatus(orderModel.recieveTime!);
        ordersList.add(orderModel);
        orderModel.recieveTime!.month == currentMonth
            ? categorizedList.add(orderModel)
            : null;
        isLoadingActionsOrder = false;
        _resetOrderModel();
        emit(SuccessAddNewOrderState(lastAdded: ordersList.last));
      }, (error) {
        isLoadingActionsOrder = false;
        emit(FailureAddNewOrderState());
      });
    }
  }

  void updateOrderModel(CustomerModel newCustomerModel) {
    orderModel.customerModel = newCustomerModel;
    orderModel.customerId = newCustomerModel.customerId;
    pillModel.customerName = newCustomerModel.customerName!;
  }

  Future<void> addNewKitchenType(Emitter<ManagementState> emit) async {
    if (orderModel.kitchenType != null &&
        !allKitchenTypes.contains(orderModel.kitchenType)) {
      final resultType =
          await managementRepoImpl.addNewKitchenType(orderModel.kitchenType!);
      resultType.fold((success) {
        emit(SuccessGetAllKitchenTypesState());
      }, (error) {
        emit(FailureGetAllKitchenTypesState(errMessage: error));
      });
    }
  }

  void _resetOrderModel() {
    orderId = const Uuid().v1();
    customerId = const Uuid().v4();
    orderModel = OrderModel();
    customerModel = CustomerModel(customerId: "");
    pillModel = PillModel(pillId: const Uuid().v4());
    colorModel = ColorOrderModel(colorId: const Uuid().v4());
    extraOrdersList = [];
    mediaOrderList = [];
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
          : pillModel.stepsCounter > 1
              ? pillModel.stepsCounter--
              : 1;
    }
    emit(ChangePaymentWayState());
  }

  FutureOr<void> changeRemianInAddOrder(
      ChangeRemainInAddOrderEvent event, Emitter<ManagementState> emit) async {
    if (event.isEdit) {
      editableOrderModel.pillModel?.remian = convertToArabicNumbers(
          (BigInt.parse(convertToEnglishNumbers(
                      editableOrderModel.pillModel!.totalMoney)) -
                  (BigInt.parse(convertToEnglishNumbers(
                          editableOrderModel.pillModel!.payedAmount)) +
                      BigInt.parse(convertToEnglishNumbers(
                          editableOrderModel.pillModel!.interior))))
              .toString());
    } else {
      pillModel.remian = convertToArabicNumbers(
          (BigInt.parse(convertToEnglishNumbers(pillModel.totalMoney)) -
                  BigInt.parse(convertToEnglishNumbers(pillModel.interior)))
              .toString());
    }

    emit(ChangeColorDegreeState());
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
    pillModel.orderId = orderId;
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
    editableOrderModel.pillModel = event.orderModel.pillModel;

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
    if (!isLoadingActionsOrder) {
      isLoadingActionsOrder = true;
      emit(LoadingEditOrderState());
      final result = await managementRepoImpl.editCurrentOrder(
          editableOrderModel, removedMedia, removedExtra);
      result.fold((success) {
        int index = ordersList
            .indexWhere((test) => test.orderId == editableOrderModel.orderId);
        ordersList[index] = editableOrderModel;
        int catIndex = categorizedList
            .indexWhere((test) => test.orderId == editableOrderModel.orderId);
        categorizedList[catIndex] = editableOrderModel;
        isLoadingActionsOrder = false;
        emit(
            SuccessEditOrderModelState(editedModel: categorizedList[catIndex]));
      }, (error) {
        isLoadingActionsOrder = false;
        emit(FailureEditOrderModelState(errMessage: error));
      });
    }
  }

  FutureOr<void> deleteCurrentOrder(
      DeleteOrderEvent event, Emitter<ManagementState> emit) async {
    if (!isLoadingActionsOrder) {
      isLoadingActionsOrder = true;
      emit(LoadingDeleteOrderModelState());
      final result = await managementRepoImpl.deleteCurrentOrder(
          event.orderId, event.mediaList);
      result.fold((success) {
        ordersList.removeWhere((test) => test.orderId == event.orderId);
        categorizedList.removeWhere((item) => item.orderId == event.orderId);
        isLoadingActionsOrder = false;
        emit(DeletedOrderSuccessState());
      }, (error) {
        isLoadingActionsOrder = false;
        emit(DeletedOrderFailureState(errMessage: error));
      });
    }
  }

  FutureOr<void> changeCurrentMonth(
      ChangeCurrentMonthEvent event, Emitter<ManagementState> emit) {
    currentMonth = event.month;
    emit(ChangeSearchedTimeState());
  }

  FutureOr<void> changeCurrentYear(
      ChangeCurrentYearEvent event, Emitter<ManagementState> emit) {
    currentYear = event.year;
    emit(ChangeSearchedTimeState());
  }

  FutureOr<void> changeSearchKey(
      ChangeSearchKeyEvent event, Emitter<ManagementState> emit) async {
    searchKey = event.searchKey;
    emit(ChangeSearchKeyState());
  }

  FutureOr<void> searchForOrder(
      SearchForOrderEvent event, Emitter<ManagementState> emit) async {
    if (event.enable) {
      searchList = [];
      enableSearchMode = true;
      isSearchLoading = true;
      emit(LoadingGetSearchedOrderState());
      final result = await managementRepoImpl.searchForOrders(
          searchKeyWord, searchKey.valueEnSearh);
      result.fold((orders) {
        isSearchLoading = false;
        searchList.addAll(orders);
        emit(SuccessGetSearchedOrderState());
      }, (error) {
        isSearchLoading = false;
        emit(FailureGetSearchedOrderState(errMessage: error));
      });
    } else {
      enableSearchMode = false;
      searchKeyWord = '';
      searchKey = SearchModel(valueArSearh: '', valueEnSearh: '');
      emit(CloseSearchState());
    }
  }

  FutureOr<void> categorizeList(
      ChangeCategrizedListEvent event, Emitter<ManagementState> emit) async {
    if (currIndex != event.index) {
      currIndex = event.index;
      categorizedList.clear();
      switch (event.index) {
        case 0:
          categorizedList.addAll(ordersList);
          break;
        case 1:
          categorizedList = ordersList
              .where((item) => item.orderStatus == OrderStatus.finished)
              .toList();
          break;
        case 2:
          categorizedList = ordersList
              .where((item) => item.orderStatus == OrderStatus.veryNear)
              .toList();
          break;
        case 3:
          categorizedList = ordersList
              .where((item) => item.orderStatus != OrderStatus.finished)
              .toList();
          break;
      }
      emit(ChangeCategorizedState());
    }
  }

  FutureOr<void> markOrderAsDoneOrNotDone(
      MarkOrderAsDelievredEvent event, Emitter<ManagementState> emit) async {
    emit(LoadingEditOrderModelState());

    final result = await managementRepoImpl.markOrderAsDone(
        event.orderId, event.makeItDone ? 2 : 0);
    return result.fold((success) {
      ordersList
              .firstWhere((item) => item.orderId == event.orderId)
              .orderStatus =
          event.makeItDone ? OrderStatus.finished : OrderStatus.neverDone;
      categorizedList
              .firstWhere((item) => item.orderId == event.orderId)
              .orderStatus =
          event.makeItDone ? OrderStatus.finished : OrderStatus.neverDone;
      emit(MakeOrderDeliverOrNotSuccessState(
          successMessage: event.makeItDone
              ? "تم تسليم الطلب بنجاح "
              : "ارجاع الطلب الي العناصر الغير المسلمة"));
    }, (error) {
      log(error);
      emit(FailureEditOrderModelState(errMessage: error));
    });
  }
}
