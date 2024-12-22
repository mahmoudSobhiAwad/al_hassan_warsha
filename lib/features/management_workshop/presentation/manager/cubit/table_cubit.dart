import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'table_state.dart';

class TableCubit extends Cubit<TableState> {
  TableCubit() : super(TableInitialState());

  final TextEditingController rowsController = TextEditingController();
  final TextEditingController columnsController = TextEditingController();
  late List<double> columnWidths;
  late List<double> rowHeights;
  late List<double> cellHeights;
  final ScrollController scrollController = ScrollController();
  int rowsNum = 0;
  int colsNum = 0;
  bool isTableCreated = false;

  // fucntion to create the table
  void createTable() {
    if (rowsController.text.trim().isNotEmpty &&
        columnsController.text.trim().isNotEmpty) {
      rowsNum = int.tryParse(rowsController.text) ?? 0;
      colsNum = int.tryParse(columnsController.text) ?? 0;
      if (rowsNum * colsNum > 100) {
        emit(FailureCreateOrEditTableState(errMessage: "عدد كبير للجدول"));
      } else if (rowsNum * colsNum < 1) {
        emit(FailureCreateOrEditTableState(errMessage: "العدد اقل من صفر"));
      } else {
        isTableCreated = true;
        initDimensions();
        emit(CreateOrEditTableState());
      }
    } else {
      emit(FailureCreateOrEditTableState(errMessage: "المدخل غير صحيح"));
    }
  }

  void initDimensions() {
    columnWidths = List.filled(colsNum, 100.0);
    rowHeights = List.filled(rowsNum, 50.0);
    cellHeights = List.generate(rowsNum, (index) => 50);
  }

  void adjustCellHeight(int rowIndex, int colIndex, double newHeight) {
    double clampedHeight = newHeight.clamp(50.0, double.infinity);
    cellHeights[rowIndex] = clampedHeight;
    rowHeights.reduce((a, b) => a > b ? a : b);
    emit(UpdateTableRowOrColumnDimensionsState());
  }

  void adjustColumnWidth(int colIndex, double newWidth) {
    columnWidths[colIndex] = newWidth.clamp(50.0, double.infinity);
    emit(UpdateTableRowOrColumnDimensionsState());
  }

  void adjustRowHeight(int rowIndex, double newHeight) {
    rowHeights[rowIndex] = newHeight.clamp(50.0, double.infinity);
    emit(UpdateTableRowOrColumnDimensionsState());
  }
}
