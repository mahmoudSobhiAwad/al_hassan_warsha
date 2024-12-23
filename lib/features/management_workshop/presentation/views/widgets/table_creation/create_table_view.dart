import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_snack_bar.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/app_bar_with_linking.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/cubit/table_cubit.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/table_creation/create_table_button_with_fields.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/table_creation/get_pdf.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/table_creation/interactive_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TableManager extends StatelessWidget {
  const TableManager({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TableCubit(),
      child: BlocConsumer<TableCubit, TableState>(
        listener: (context, state) {
          if (state is FailureCreateOrEditTableState) {
            showCustomSnackBar(context, state.errMessage ?? "",
                backgroundColor: AppColors.red);
          }
        },
        builder: (context, state) {
          var tableCubit = context.read<TableCubit>();
          return Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: AppColors.white,
                body: Column(
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
                        tableCubit.createTable();
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
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
                                  {required colorValue,
                                  required columnIndex,
                                  required rowIndex}) =>
                              tableCubit.changeBackGroundForCell(
                                  colorValue: colorValue,
                                  colIndex: columnIndex,
                                  rowIndex: rowIndex),
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
                        ),
                      ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
