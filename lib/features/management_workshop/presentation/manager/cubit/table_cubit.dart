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
  bool enableCounter = false;
  bool isRowUpdated = false;
  bool isColumnUpdated = false;
  List<List<CellInTableModel>> cellList = [];
  // fucntion to create the table
  void createTable(double initWidth) {
    if (rowsController.text.trim().isNotEmpty &&
        columnsController.text.trim().isNotEmpty) {
      rowsNum = int.tryParse(rowsController.text) ?? 0;
      colsNum = int.tryParse(columnsController.text) ?? 0;
      if (rowsNum * colsNum > 100) {
        rowsNum = colsNum = 0;
        emit(FailureCreateOrEditTableState(errMessage: "عدد كبير للجدول"));
      } else if (rowsNum * colsNum < 1) {
        rowsNum = colsNum = 0;
        isTableCreated ? cellList.clear() : null;
        emit(FailureCreateOrEditTableState(
            errMessage: "العدد لا يمكن ان يساوي صفر"));
      } else {
        if (isTableCreated) {
          columnWidths.clear();
          rowHeights.clear();
        }
        isTableCreated = true;
        initTableDimensionsWithContent(initWidth);
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

  void initTableDimensionsWithContent(double initWidth) {
    columnWidths = List.filled(colsNum, initWidth / colsNum, growable: true);
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

  void changeInsertOption(int index, {bool isRemove = false}) {
    if (isRemove) {
      removeOptionList[index].setIsActive = true;
      for (int i = 0; i < removeOptionList.length; i++) {
        index != i ? removeOptionList[i].setIsActive = false : null;
      }
    } else {
      insertOptionList[index].setIsActive = true;
      for (int i = 0; i < insertOptionList.length; i++) {
        index != i ? insertOptionList[i].setIsActive = false : null;
      }
    }
    emit(ChangeCheckedBoxForAnyState());
  }

  void changeFontSize(
      {required bool fontState, required int colIndex, required int rowIndex}) {
    cellList[rowIndex][colIndex].setFontSize = fontState;
    emit(ChangeFontSizeState());
  }

  void insertOperationInTable(InsertType insertType,
      {int? insertedRowIndex, int? insertedColIndex}) {
    switch (insertType) {
      case InsertType.addBelowRow:
        insertRow(
          insertedIndex: insertedRowIndex,
        );
        break;
      case InsertType.addAboveRow:
        insertRow(insertedIndex: insertedRowIndex, isBelow: false);
        break;
      case InsertType.addRightCol:
        insertColumn(insertedIndex: insertedColIndex);
        break;
      case InsertType.addLeftCol:
        insertColumn(insertedIndex: insertedColIndex, isRight: false);
        break;
    }

    emit(UpdateTableRowOrColumnState());
  }

  void removeOptionInTable(RemoveType removeType,
      {required int removedRowIndex, required int removedColIndex}) {
    switch (removeType) {
      case RemoveType.removeEntireRow:
        removeEntireRow(removedRowIndex);
        break;
      case RemoveType.removeEntireCol:
        removeEntireCol(removedColIndex);
        break;
    }

    emit(UpdateTableRowOrColumnState());
  }

  void insertRow({int? insertedIndex, bool isBelow = true}) {
    rowsNum++;
    // Append a new row to the cell list
    List<CellInTableModel> newRow =
        List.generate(colsNum, (colIndex) => CellInTableModel());
    if (insertedIndex != null) {
      cellList.insert(isBelow ? insertedIndex + 1 : insertedIndex, newRow);
      rowHeights.insert(isBelow ? insertedIndex + 1 : insertedIndex, 50.0);
      if (enableCounter) {
        for (int i = 1; i < rowsNum; i++) {
          cellList[i][0].setContentInCell = i.toString();
        }
      }
    } else {
      cellList.add(newRow);
      rowHeights.add(50.0); // Add default height for the new row
      if (enableCounter) {
        cellList[rowsNum - 1][0].setContentInCell = (rowsNum - 1).toString();
      }
    }
  }

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

  void insertColumn({int? insertedIndex, bool isRight = true}) {
    colsNum++; // Increment the total number of columns
    // Loop through each row and insert a new cell
    if (insertedIndex != null) {
      for (int rowIndex = 0; rowIndex < rowsNum; rowIndex++) {
        final newCell = CellInTableModel(); // Create a new cell
        cellList[rowIndex].insert(
          isRight ? insertedIndex : insertedIndex + 1,
          newCell,
        );
      }
      columnWidths.insert(isRight ? insertedIndex : insertedIndex + 1, 150);
    }
  }

  void removeEntireRow(int removedRowIndex) {
    cellList.removeAt(removedRowIndex);
    rowHeights.removeAt(removedRowIndex);
    rowsNum--;
    if (enableCounter&&cellList[0][0].getContentofCell=='ترتيب') {
      for (int i = 1; i < rowsNum; i++) {
        cellList[i][0].setContentInCell = i.toString();
      }
    }
  }

  void removeEntireCol(int removedColIndex) {
    for (int rowIndex = 0; rowIndex < rowsNum; rowIndex++) {
      cellList[rowIndex].removeAt(removedColIndex);
    }

    columnWidths.removeAt(removedColIndex);
    colsNum--;
  }
}
