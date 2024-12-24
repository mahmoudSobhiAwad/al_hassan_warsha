import 'package:al_hassan_warsha/core/utils/functions/extentions.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/app_bar_with_linking.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/table_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/cubit/table_cubit.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/show_color_picker.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/table_creation/add_rows_columns_dialog.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/table_creation/create_table_button_with_fields.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/table_creation/edit_font_style_dialog.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/table_creation/get_pdf.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/table_creation/interactive_table.dart';
import 'package:flutter/material.dart';

class CreateTableBody extends StatelessWidget {
  const CreateTableBody({
    super.key,
    required this.tableCubit,
  });

  final TableCubit tableCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppBarWithLinking(
          items: ["إنشاء جدول"],
          fontSize: 18,
          iconSize: 30,
        ),
        const SizedBox(height: 10),
        CreateTableFieldsWithButton(
          rowsController: tableCubit.rowsController,
          columnsController: tableCubit.columnsController,
          enableCounter: tableCubit.enableCounter,
          enableOrDisableCounter: () {
            tableCubit.enableOrDisableCounter();
          },
          createTable: () {
            tableCubit.createTable(context.screenWidth * 0.8);
          },
        ),
        const SizedBox(height: 15),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: CustomPushContainerButton(
              borderRadius: 12,
              onTap: () {
                generateTablePdf(
                    rows: tableCubit.rowsNum,
                    columns: tableCubit.colsNum,
                    cellList: tableCubit.cellList,
                    columnWidths: tableCubit.columnWidths,
                    rowHeights: tableCubit.rowHeights);
              },
              color: AppColors.darkBlue
                  .withOpacity(tableCubit.isTableCreated ? 1 : 0.3),
              pushButtomText: "طباعة الجدول",
              pushButtomTextFontSize: 18,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              iconSize: 30,
              iconBehind: Icons.file_present_rounded,
            ),
          ),
        ),
        const SizedBox(height: 40),
        if (tableCubit.isTableCreated)
          Expanded(
            child: InteractiveTable(
              changeColorValue: (
                  {required columnIndex, required rowIndex}) async {
                await showColorPicker(context, onColorChanged: (color) {
                  tableCubit.changeBackGroundForCell(
                      colorValue: color.value,
                      colIndex: columnIndex,
                      rowIndex: rowIndex);
                });
              },
              rows: tableCubit.rowsNum,
              columns: tableCubit.colsNum,
              columnWidths: tableCubit.columnWidths,
              rowHeights: tableCubit.rowHeights,
              scrollController: tableCubit.scrollController,
              adjustColumnWidth: (int colIndex, double newWidth) {
                tableCubit.adjustColumnWidth(colIndex, newWidth);
              },
              adjustRowHeight: (int rowIndex, double newHeight) {
                tableCubit.adjustRowHeight(rowIndex, newHeight);
              },
              cellList: tableCubit.cellList,
              changeFontValue: (
                  {required int columnIndex, required int rowIndex}) async {
                await changeFontSize(
                    cubit: tableCubit,
                    context,
                    colIndex: columnIndex,
                    rowIndex: rowIndex);
              },
              addNewRow: () {
                tableCubit
                    .insertOperationInTable(insertOptionList[0].getInsertType);
              },
              insertNewRowOrCol: (
                  {required int columnIndex, required int rowIndex}) {
                addNewRowOrColumn(context, tableCubit,
                    colIndex: columnIndex, rowIndex: rowIndex);
              },
              deleteRowOrCol: (
                  {required int columnIndex, required int rowIndex}) {
                
              },
            ),
          ),
        const SizedBox(height: 20),
      ],
    );
  }
}
