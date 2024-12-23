import 'package:al_hassan_warsha/features/management_workshop/data/models/table_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'table_state.dart';

class TableCubit extends Cubit<TableState> {
  TableCubit() : super(TableInitialState());

  final TextEditingController rowsController = TextEditingController();
  final TextEditingController columnsController = TextEditingController();
  late List<double> columnWidths;
  late List<double> rowHeights;
  // late List<double> cellHeights;
  final ScrollController scrollController = ScrollController();
  int rowsNum = 0;
  int colsNum = 0;
  bool isTableCreated = false;
  bool enableCounter = true;
  List<List<CellInTableModel>> cellList = [];

  // TODO: change font size for each cell from right click
  // TODO: add new row button - from right click
  // TODO: add new column from right click
  // TODO: delete row,column from right click.
 

  // fucntion to create the table
  void createTable() {
    if (rowsController.text.trim().isNotEmpty &&
        columnsController.text.trim().isNotEmpty) {
      rowsNum = int.tryParse(rowsController.text) ?? 0;
      colsNum = int.tryParse(columnsController.text) ?? 0;
      if (rowsNum * colsNum > 100) {
        rowsNum = colsNum = 0;
        emit(FailureCreateOrEditTableState(errMessage: "عدد كبير للجدول"));
      } else if (rowsNum * colsNum < 1) {
        emit(FailureCreateOrEditTableState(
            errMessage: "العدد لا يمكن ان يساوي صفر"));
      } else {
        if (isTableCreated) {
          columnWidths.clear();
          rowHeights.clear();
        }
        isTableCreated = true;
        initTableDimensionsWithContent();
        emit(CreateOrEditTableState());
      }
    } else {
      emit(FailureCreateOrEditTableState(errMessage: "المدخل غير صحيح"));
    }
  }

  void enableOrDisableCounter() {
    enableCounter = !enableCounter;
    emit(EnableOrDisableCounterState());
  }

  void initTableDimensionsWithContent() {
    columnWidths = List.filled(colsNum, 100.0, growable: true);
    rowHeights = List.filled(rowsNum, 50.0, growable: true);
    // cellList = List.filled(rowsNum,growable: true ,List.filled(colsNum, CellInTableModel()));
    cellList = List.generate(rowsNum, (rowIndex) {
      return List.generate(colsNum, (colIndex) => CellInTableModel());
    });
    if (enableCounter) {
      // Set the first cell in the first row (first column) to "ترتيب"
      cellList[0][0].setContentInCell = 'ترتيب';

      // Fill the first column (except the first row) with index numbers starting from 1
      int index = 1;
      for (var rowIndex = 1; rowIndex < rowsNum; rowIndex++) {
        cellList[rowIndex][0].setContentInCell = index.toString();
        index++;
      }
    }
  }

  // void adjustCellHeight(int rowIndex, int colIndex, double newHeight) {
  //   double clampedHeight = newHeight.clamp(50.0, double.infinity);
  //  // cellHeights[rowIndex] = clampedHeight;
  //   rowHeights.reduce((a, b) => a > b ? a : b);
  //   emit(UpdateTableRowOrColumnDimensionsState());
  // }

  void changeBackGroundForCell(
      {required int colorValue, required int colIndex, required int rowIndex}) {
    cellList[rowIndex][colIndex].setBackgroundColorHex = colorValue;
    emit(ChangeBackGroundColorState());
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
