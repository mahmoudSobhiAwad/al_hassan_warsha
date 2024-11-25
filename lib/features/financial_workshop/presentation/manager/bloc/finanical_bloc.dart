import 'dart:async';

import 'package:al_hassan_warsha/features/financial_workshop/data/repos/financial_repo_impl.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
  }
  bool isLoading = false;
  bool isLoadingUpdateCounter = false;
  int currIndex = 0;
  int totalLengthOfAllOrders = 0;
  List<OrderModel> orderList = [];
  int pageIndex = 1;
  FutureOr<void> fetchAllOrder(
    FetchAllOrderWithThierBillEvent event,
    Emitter<FinanicalState> emit,
  ) async {
    isLoading = true;

    emit(LoadingFetchOrderState());
    final result = await financialRepoImpl.getAllBills(
        offset: event.offset * orderList.length);
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
          await financialRepoImpl.downStep(event.pillId, event.remianAmount);
      return result.fold((changedPill) {
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
  }

  FutureOr<void> changePageInFetchOrder(
      ChangePageInFetchOrderEvent event, Emitter<FinanicalState> emit) async {
    if (event.index != pageIndex) {
      pageIndex = event.index;
      emit(ChangeCurrentPageState());
      add(FetchAllOrderWithThierBillEvent(offset: pageIndex-1));
    }
  }
}
