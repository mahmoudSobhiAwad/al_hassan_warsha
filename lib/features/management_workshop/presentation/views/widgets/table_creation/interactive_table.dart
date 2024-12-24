import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/table_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/table_creation/table_cell_widget.dart';
import 'package:flutter/material.dart';

class InteractiveTable extends StatelessWidget {
  final int rows;
  final int columns;
  final List<double> columnWidths;

  final List<double> rowHeights;
  final List<List<CellInTableModel>> cellList;
  final ScrollController scrollController;
  final void Function(int colIndex, double newWidth) adjustColumnWidth;
  final void Function(int rowIndex, double newHeight) adjustRowHeight;
  final void Function() addNewRow;
  final void Function({required int rowIndex, required int columnIndex})
      changeColorValue;
  final void Function({required int rowIndex, required int columnIndex})
      changeFontValue;
  final void Function({required int rowIndex, required int columnIndex})
      insertNewRowOrCol;
  final void Function({required int rowIndex, required int columnIndex})
      deleteRowOrCol;

  const InteractiveTable({
    required this.rows,
    required this.cellList,
    required this.columns,
    required this.columnWidths,
    required this.rowHeights,
    required this.scrollController,
    required this.adjustColumnWidth,
    required this.adjustRowHeight,
    required this.changeColorValue,
    super.key,
    required this.changeFontValue,
    required this.addNewRow,
    required this.insertNewRowOrCol,
    required this.deleteRowOrCol,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30.0, left: 20),
        child: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(scrollbars: false),
          child: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            child: Scrollbar(
              scrollbarOrientation: ScrollbarOrientation.right,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    primary: true,
                    scrollDirection: Axis.vertical,
                    child: Column(children: [
                      ...List.generate(
                        rows,
                        (rowIndex) => Row(
                          children: List.generate(
                            columns,
                            (colIndex) => Stack(
                              children: [
                                // Cell Content
                                TableCellWidget(
                                  cellItem: cellList[rowIndex][colIndex],
                                  width: columnWidths[colIndex],
                                  height: rowHeights[rowIndex],
                                  changeColorValue: () {
                                    changeColorValue(
                                        columnIndex: colIndex,
                                        rowIndex: rowIndex);
                                  },
                                  changeFontValue: () {
                                    changeFontValue(
                                        columnIndex: colIndex,
                                        rowIndex: rowIndex);
                                  },
                                  insertNewRowOrCol: () {
                                    insertNewRowOrCol(
                                        columnIndex: colIndex,
                                        rowIndex: rowIndex);
                                  },
                                  deleteRowOrCol: () {
                                    deleteRowOrCol(
                                        columnIndex: colIndex,
                                        rowIndex: rowIndex);
                                  },
                                ),
                                // Column Resizing Handle
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  right: 0,
                                  width: 10, // Handle Width
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.resizeColumn,
                                    child: GestureDetector(
                                      onHorizontalDragUpdate: (details) {
                                        adjustColumnWidth(
                                          colIndex,
                                          columnWidths[colIndex] +
                                              details.primaryDelta!,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                // Row Resizing Handle
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  height: 10, // Handle Height
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.resizeRow,
                                    child: GestureDetector(
                                      onVerticalDragUpdate: (details) {
                                        adjustRowHeight(
                                          rowIndex,
                                          rowHeights[rowIndex] +
                                              details.primaryDelta!,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      cellList.isNotEmpty
                          ? IconButton(
                              onPressed: addNewRow,
                              icon: const Icon(
                                Icons.add_circle,
                                color: AppColors.blue,
                                size: 40,
                              ))
                          : const SizedBox(),
                      const SizedBox(
                        height: 10,
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
