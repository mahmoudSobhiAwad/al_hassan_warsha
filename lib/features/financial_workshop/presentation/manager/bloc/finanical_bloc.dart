import 'dart:async';

import 'package:al_hassan_warsha/features/financial_workshop/data/models/transaction_model.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/repos/financial_repo_impl.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

part 'finanical_event.dart';
part 'finanical_state.dart';

class FinanicalBloc extends Bloc<FinanicalEvent, FinanicalState> {
  final FinancialRepoImpl financialRepoImpl;

  FinanicalBloc({required this.financialRepoImpl})
      : super(FinanicalInitialState()) {
    on<FetchAllOrderWithThierBillEvent>(fetchAllOrder);
    on<ChangeCurrentIndexEvent>(changeCurrIndex);
    on<DownStepCounterEvent>(updateStepCounterForModel);
    on<ChangePageInFetchOrderEvent>(changePageInFetchOrder);
    on<EnableOrDisableSearchEvent>(changeSearchMood);
    on<ChangeSearchModelEvent>(changeSearchModel);
    on<ChangeSearchKeyWordEvent>(changeSearchKeyWord);
    on<ChangePaymentTypeEvent>(changePaymentType);
    on<ChangeHistoryOfTransactionEvent>(changeHistoryOfTransaction);
    on<ChangeTransactionMethodEvent>(changeTransactionMethod);
    on<AddNewTransactionEvent>(addNewTransaction);
    on<ChangeCurrentMonthEvent>(changeCurrentMonth);
    on<ChangeCurrentYearEvent>(changeCurrentYear);
    on<DeleteTransactionEvent>(deleteTransaction);
    on<GetAllTransactionEvent>(getAllTransaction);
  }

  // related to transaction//
  TransactionModel transactionModel = TransactionModel();
  int currTransYear = DateTime.now().year;
  int currTransMonth = DateTime.now().month;
  bool isLoadingTransaction = false;
  List<TransactionModel> transactionList = [];
  final formKey = GlobalKey<FormState>();
  //-----------------//

  //Searched data
  List<OrderModel> searchedList = [];
  bool searchMood = false;
  bool isLoadingSearch = false;
  String searchKeyWord = '';
  SearchModel farzModel = SearchModel(valueArSearh: "الكل", valueEnSearh: "-1");
  SearchModel searchModel = SearchModel(valueArSearh: "", valueEnSearh: "");
  //

  bool isLoading = false;
  bool isLoadingUpdateCounter = false;
  int currIndex = 0;
  final scrollController = ScrollController();

  int totalLengthOfAllOrders = 0;
  List<OrderModel> orderList = [];
  int pageIndex = 1;
  //all function related to financial orders//
  FutureOr<void> fetchAllOrder(
    FetchAllOrderWithThierBillEvent event,
    Emitter<FinanicalState> emit,
  ) async {
    isLoading = true;

    emit(LoadingFetchOrderState());
    final result = await financialRepoImpl.getAllBills(
        offset: event.offset * orderList.length,
        optionPaymentWay: event.farzIndex == -1 ? null : event.farzIndex);
    result.fold((data) {
      orderList.clear();
      orderList.addAll(data.$1);
      totalLengthOfAllOrders = data.$2;
      isLoading = false;
      emit(SuccessFetchOrderState());
    }, (error) {
      isLoading = false;

      emit(FailureFetchOrderState(errMessage: error));
    });
  }

  FutureOr<void> updateStepCounterForModel(
      DownStepCounterEvent event, Emitter<FinanicalState> emit) async {
    if (!isLoadingUpdateCounter) {
      isLoadingUpdateCounter = true;
      emit(LoadingUpdateCounterOrderState());
      final result =
          await financialRepoImpl.downStep(event.pillId, event.remianAmount,event.orderName,event.payed);
      return result.fold((changedPill) {
        if (searchedList.isNotEmpty) {
          searchedList
              .firstWhere((item) => item.pillModel!.pillId == event.pillId)
              .pillModel = changedPill;
        }
        orderList
            .firstWhere((item) => item.pillModel!.pillId == event.pillId)
            .pillModel = changedPill;
        isLoadingUpdateCounter = false;
        emit(SuccessUpdateCounterOrderState());
      }, (error) {
        isLoadingUpdateCounter = false;

        emit(FailureFetchOrderState(errMessage: error));
      });
    }
  }

  FutureOr<void> changeCurrIndex(
      ChangeCurrentIndexEvent event, Emitter<FinanicalState> emit) async {
    currIndex = event.index;
    emit(ChangeIndexState());
    switch (event.index) {
      case 1:
        if (transactionList.isEmpty) {
          add(GetAllTransactionEvent());
        }
        break;
    }
  }

  FutureOr<void> changePageInFetchOrder(
      ChangePageInFetchOrderEvent event, Emitter<FinanicalState> emit) async {
    if (event.index != pageIndex) {
      pageIndex = event.index;
      emit(ChangeCurrentPageState());
      add(FetchAllOrderWithThierBillEvent(offset: pageIndex - 1));
    }
  }

  FutureOr<void> changeSearchModel(
      ChangeSearchModelEvent event, Emitter<FinanicalState> emit) async {
    if (event.isFarz) {
      if (event.model.valueEnSearh != farzModel.valueEnSearh) {
        farzModel = event.model;
        add(FetchAllOrderWithThierBillEvent(
            farzIndex: int.parse(event.model.valueEnSearh)));
      }
    } else {
      searchModel = event.model;
    }

    emit(ChangeSearchModelState());
  }

  FutureOr<void> changeSearchMood(
      EnableOrDisableSearchEvent event, Emitter<FinanicalState> emit) async {
    if (event.status) {
      searchedList.clear();
      searchMood = true;
      emit(LoadingFetchOrderState());
      final result = await financialRepoImpl.searchForOrder(
          searchKeyWord: searchKeyWord,
          parameterSearch: searchModel.valueEnSearh);
      result.fold((list) {
        searchedList.addAll(list);
        emit(SuccessFetchOrderState());
      }, (error) {
        emit(FailureFetchOrderState(errMessage: error));
      });
    } else {
      searchedList.clear();
      searchKeyWord = "";
      searchModel = SearchModel(valueArSearh: "", valueEnSearh: "");
      searchMood = false;
    }
    emit(ChangeSearchMoodState());
  }

  FutureOr<void> changeSearchKeyWord(
      ChangeSearchKeyWordEvent event, Emitter<FinanicalState> emit) async {
    searchKeyWord = event.text;
  }

//-----------------------------------//

// function related to transaction //

  FutureOr<void> getAllTransaction(
      GetAllTransactionEvent event, Emitter<FinanicalState> emit) async {
    isLoadingTransaction = true;
    emit(LoadingGetAllTransactionState());
    final result = await financialRepoImpl.getAllTransaction(
        month: currTransMonth, year: currTransYear);
    result.fold((list) {
      transactionList.clear();
      transactionList.addAll(list);
      emit(SuccessGetAllTransactionState());
    }, (error) {
      emit(FailureGetAllTransactionState(errMessage: error));
    });
  }

  FutureOr<void> changePaymentType(
      ChangePaymentTypeEvent event, Emitter<FinanicalState> emit) async {
    transactionModel.transactionType = event.type;
    emit(ChangeTransactionWayState());
  }

  FutureOr<void> changeHistoryOfTransaction(
      ChangeHistoryOfTransactionEvent event,
      Emitter<FinanicalState> emit) async {
    transactionModel.transactionTime = event.time;
    emit(ChangeTransactionHistoryState());
  }

  FutureOr<void> changeTransactionMethod(
      ChangeTransactionMethodEvent event, Emitter<FinanicalState> emit) async {
    transactionModel.transactionMethod = event.method;
    emit(ChangeTransactionMethodState());
  }

  FutureOr<void> addNewTransaction(
      AddNewTransactionEvent event, Emitter<FinanicalState> emit) async {
    emit(LoadingAddTransactionState());
    transactionModel.transactionId = const Uuid().v4();
    final result =
        await financialRepoImpl.addTransaction(model: transactionModel);
    result.fold((model) {
      if (model.transactionTime!.month == currTransMonth) {
        transactionList.add(model);
      }

      transactionModel.transactionAmount = '0';
      transactionModel.transactionName = '';
      transactionModel.transactionTime = null;
      emit(SuccessAddTransactionState());
    }, (error) {
      emit(FailureAddTransactionState(errMessage: error));
    });
  }

  FutureOr<void> changeCurrentMonth(
      ChangeCurrentMonthEvent event, Emitter<FinanicalState> emit) async {
    currTransMonth = event.currentMonth;
    emit(ChangeCurYearState());
  }

  FutureOr<void> changeCurrentYear(
      ChangeCurrentYearEvent event, Emitter<FinanicalState> emit) async {
    currTransYear = event.year;
    emit(ChangeCurYearState());
  }

  FutureOr<void> deleteTransaction(
      DeleteTransactionEvent event, Emitter<FinanicalState> emit) async {
    emit(LoadingDeleteTransactionState());
    var result =
        await financialRepoImpl.removeTransation(id: event.transactionId);
    result.fold((success) {
      transactionList
          .removeWhere((model) => model.transactionId == event.transactionId);
      emit(SuccessDeleteTransactionState());
    }, (error) {
      emit(FailureDeleteTransactionState(errMessage: error));
    });
  }
  //----------------------------//
}
