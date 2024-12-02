import 'dart:async';

import 'package:al_hassan_warsha/core/utils/functions/temp_crud_operation.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/analysis_model.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/salary_model.dart';
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
    on<ChangeAllTransactionTypesEvent>(changeAllTransactionTypes);
    on<AddNewTransactionEvent>(addNewTransaction);
    on<ChangeCurrentMonthEvent>(changeCurrentMonth);
    on<ChangeCurrentYearEvent>(changeCurrentYear);
    on<DeleteTransactionEvent>(deleteTransaction);
    on<GetAllTransactionEvent>(getAllTransaction);
    on<GetAllWorkersDataEvent>(getAllWorkersData);
    on<SelectWorkerEvent>(selectWorker);
    on<AddNewWorkerEvent>(addNewWorker);
    on<DeleteWorkerEvent>(deleteWorker);
    on<ChangeSalaryTypeEvent>(changeSalaryType);
    on<SaveChangesAddOrEditEvent>(saveChanges);
    on<EnableEditForWorkersEvent>(enableEditForWorkers);
    on<PayAllSalariesEvent>(payAllSalaries);
    on<ChangeStartOrEndDateEvent>(changeStartOrEndDate);
    on<MakeAnalysisEvent>(makeAnalysis);
  }
  @override
  Future<void> close() async {
    await TempCrudOperation.closeDb();
    return super.close(); // Ensure the parent close method is called
  }

  // related to transaction//
  TransactionModel transactionModel = TransactionModel();
  int currTransYear = DateTime.now().year;
  int currTransMonth = DateTime.now().month;
  bool isLoadingTransaction = false;
  List<TransactionModel> transactionList = [];
  final formKey = GlobalKey<FormState>();
  //-----------------//

//analysis //
  AnalysisModelData? analysisModelData;
  DateTime? startDate;
  DateTime? endDate;
  bool isAnalysisLoading = false;
// ------//
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

  //realted to workers //
  bool isLoadingActionWorker = false;
  bool isLoadingGetAllWorkers = false;
  bool isAllSelected = false;
  List<WorkerModel> workersList = [];
  bool isEditEnabled = false;
  //                //

  FutureOr<void> changeStartOrEndDate(
      ChangeStartOrEndDateEvent event, Emitter<FinanicalState> emit) async {
    if (event.startDate != null) {
      startDate = event.startDate!;
    } else if (event.endDate != null) {
      endDate = event.endDate!;
    }
    emit(ChanegeStartOrEndDateState());
  }

  FutureOr<void> makeAnalysis(
      MakeAnalysisEvent event, Emitter<FinanicalState> emit) async {
    if (startDate != null && endDate != null) {
      isAnalysisLoading = true;
      emit(LoadingAnalysisState());
      final result = await financialRepoImpl.getAnalysisUponTimeRange(
          startDate!.toIso8601String(), endDate!.toIso8601String());
      result.fold((model) {
        isAnalysisLoading = false;
        analysisModelData = model;
        emit(SuccessAnalysisState());
      }, (error) {
        isAnalysisLoading = false;
        emit(FailureAnalysisState(errMessage: error));
      });
    } else {
      emit(FailureAnalysisState(
          errMessage: "بداية الوقت او نهايته لا يمكن ان يكونو فارغين"));
    }
  }

// all function related to workers
  FutureOr<void> getAllWorkersData(
      GetAllWorkersDataEvent event, Emitter<FinanicalState> emit) async {
    isLoadingGetAllWorkers = true;
    workersList.clear();
    emit(LoadingFetchAllWorkersDateState());
    final result = await financialRepoImpl.getAllWokersData();
    result.fold((workers) {
      workersList.addAll(workers);
      isLoadingGetAllWorkers = false;
      emit(SuccessFetchAllWorkersDateState());
    }, (error) {
      isLoadingGetAllWorkers = false;
      emit(FailureFetchAllWorkersDateState(errMessage: error));
    });
  }

  FutureOr<void> payAllSalaries(
      PayAllSalariesEvent event, Emitter<FinanicalState> emit) async {
    bool nothingSelected = true;
    for (var item in workersList) {
      if (item.isSelected) {
        nothingSelected = false;
        break;
      }
    }
    if (nothingSelected) {
      emit(FailurePayAllSalariesWorkersState(
          errMessage: "لا يوجد مرتبات محددة "));
    } else {
      if (!isLoadingActionWorker) {
        isLoadingActionWorker = true;
        emit(LoadingPayAllSalariesWorkersState());
        final result = await financialRepoImpl.payTheSalary(workersList);
        result.fold((success) {
          isLoadingActionWorker = false;
          for (var item in workersList) {
            item.isSelected ? item.lastAddedSalary = DateTime.now() : null;
          }
          emit(SuccessPayAllSalariesWorkersState());
          add(EnableEditForWorkersEvent(isEdit: false));
        }, (error) {
          isLoadingActionWorker = false;
          emit(FailurePayAllSalariesWorkersState(errMessage: error));
        });
      }
    }
  }

  FutureOr<void> changeSalaryType(
      ChangeSalaryTypeEvent event, Emitter<FinanicalState> emit) async {
    workersList[event.index].salaryType = event.type;
    emit(ChangeSalaryTypeState());
  }

  FutureOr<void> enableEditForWorkers(
      EnableEditForWorkersEvent event, Emitter<FinanicalState> emit) async {
    if (event.isEdit) {
      isEditEnabled = true;
      for (var item in workersList) {
        item.enableEdit = true;
      }
    } else {
      isEditEnabled = false;
      isAllSelected = false;
      workersList.removeWhere((model) => model.workerId == null);
      for (var item in workersList) {
        item.isSelected = item.enableEdit = false;
      }
    }
    emit(ChangeEnableEditState());
  }

  FutureOr<void> saveChanges(
      SaveChangesAddOrEditEvent event, Emitter<FinanicalState> emit) async {
    bool complete = true;
    for (var item in workersList.where((model) => model.isSelected)) {
      if (item.salaryAmount.isEmpty || item.workerName.isEmpty) {
        complete = false;
        emit(FailureEditWorkersData(
            errMessage: "هناك بعض البيانات مثل الاسم او المرتب فارغة"));
      }
    }
    if (complete && !isLoadingActionWorker) {
      isLoadingActionWorker = true;
      emit(LoadingEditWorkersData());
      final addedList = workersList
          .where((model) => model.isSelected && model.workerId == null)
          .toList();

      final editedList = workersList
          .where((model) => model.isSelected && model.workerId != null)
          .toList();

      final result =
          await financialRepoImpl.editWorkersData(addedList, editedList);
      return result.fold((success) {
        isEditEnabled = false;
        isLoadingActionWorker = false;
        emit(SuccessEditWorkersData());
        add(GetAllWorkersDataEvent());
      }, (error) {
        isLoadingActionWorker = false;
        emit(FailureEditWorkersData(errMessage: error));
      });
    }
  }

  FutureOr<void> selectWorker(
      SelectWorkerEvent event, Emitter<FinanicalState> emit) async {
    if (event.isSelectAll) {
      for (var item in workersList) {
        isAllSelected ? item.isSelected = false : item.isSelected = true;
      }
      isAllSelected = !isAllSelected;
    } else {
      workersList[event.index].isSelected =
          !workersList[event.index].isSelected;
      checkAllSelected();
    }
    emit(ChangeSelectedWorkersState());
  }

  FutureOr<void> addNewWorker(
      AddNewWorkerEvent event, Emitter<FinanicalState> emit) async {
    workersList
        .add(WorkerModel(workerId: null, isSelected: true, enableEdit: true));
    add(EnableEditForWorkersEvent(isEdit: true));
    checkAllSelected();
    isAllSelected = false;
    emit(AddNewWorkerInUiState());
  }

  FutureOr<void> deleteWorker(
      DeleteWorkerEvent event, Emitter<FinanicalState> emit) async {
    emit(LoadingRemoveWorkersData());
    if (workersList[event.index].workerId != null) {
      final result = await financialRepoImpl
          .removeWorker(workersList[event.index].workerId!);
      result.fold((success) {
        workersList.removeAt(event.index);
        emit(SuccessRemoveWorkersData());
      }, (error) {
        emit(FailureRemoveWorkersData(errMessage: error));
      });
    } else {
      workersList.removeAt(event.index);
      emit(SuccessRemoveWorkersData());
    }
  }

//

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
      final result = await financialRepoImpl.downStep(
          event.pillId, event.payedAmount, event.totalPayedAmount);
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
      case 2:
        if (workersList.isEmpty) {
          add(GetAllWorkersDataEvent());
        }
        break;
    }
  }

  void checkAllSelected() {
    isAllSelected = workersList.where((model) => model.isSelected).length ==
        workersList.length;
  }

  FutureOr<void> changePageInFetchOrder(
      ChangePageInFetchOrderEvent event, Emitter<FinanicalState> emit) async {
    if (event.index != pageIndex) {
      pageIndex = event.index;
      emit(ChangeCurrentPageState());
      add(FetchAllOrderWithThierBillEvent(
          offset: pageIndex - 1, farzIndex: int.parse(farzModel.valueEnSearh)));
    }
  }

  FutureOr<void> changeSearchModel(
      ChangeSearchModelEvent event, Emitter<FinanicalState> emit) async {
    pageIndex = 1;
    if (event.isFarz) {
      if (event.model.valueEnSearh != farzModel.valueEnSearh) {
        farzModel = event.model;

        add(FetchAllOrderWithThierBillEvent(
            offset: 0, farzIndex: int.parse(event.model.valueEnSearh)));
      }
    } else {
      farzModel = SearchModel(valueArSearh: "الكل", valueEnSearh: "-1");
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

  FutureOr<void> changeAllTransactionTypes(ChangeAllTransactionTypesEvent event,
      Emitter<FinanicalState> emit) async {
    transactionModel.allTransactionTypes = event.type;
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
