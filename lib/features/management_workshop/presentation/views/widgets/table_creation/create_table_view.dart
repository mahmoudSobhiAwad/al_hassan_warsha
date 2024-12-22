import 'dart:developer';

import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_snack_bar.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/app_bar_with_linking.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/cubit/table_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TableManager extends StatelessWidget {
  const TableManager({super.key});
  @override
  Widget build(BuildContext context) {
    log('rebuild');
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
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomPushContainerButton(
                        borderRadius: 12,
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
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Expanded(child: SizedBox(width: 16)),
                        Expanded(
                          flex: 3,
                          child: CustomColumnWithTextInAddNewType(
                            enableBorder: true,
                            controller: tableCubit.rowsController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9\u0660-\u0669\u06F0-\u06F9]'),
                              )
                            ],
                            text: 'عدد الصفوف',
                            borderWidth: 2,
                            textStyle: AppFontStyles.extraBoldNew16(context),
                            textLabel: '',
                          ),
                        ),
                        const Expanded(child: SizedBox(width: 16)),
                        Expanded(
                          flex: 3,
                          child: CustomColumnWithTextInAddNewType(
                            enableBorder: true,
                            controller: tableCubit.columnsController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9\u0660-\u0669\u06F0-\u06F9]'),
                              )
                            ],
                            text: 'عدد الاعمدة',
                            borderWidth: 2,
                            textStyle: AppFontStyles.extraBoldNew16(context),
                            textLabel: '',
                          ),
                        ),
                        const Expanded(child: SizedBox(width: 16)),
                        CustomPushContainerButton(
                          onTap: tableCubit.isTableCreated
                              ? null
                              : () {
                                  tableCubit.createTable();
                                },
                          pushButtomText: "إنشاء جدول",
                          pushButtomTextFontSize: 16,
                          borderRadius: 12,
                          iconBehind: Icons.create,
                          iconSize: 30,
                          padding: const EdgeInsets.all(10),
                        ),
                        const Expanded(child: SizedBox(width: 16)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (tableCubit.isTableCreated)
                      Expanded(
                        child: InteractiveTable(
                          rows: tableCubit.rowsNum,
                          columns: tableCubit.colsNum,
                          cellHeights: tableCubit.cellHeights,
                          columnWidths: tableCubit.columnWidths,
                          rowHeights: tableCubit.rowHeights,
                          scrollController: tableCubit.scrollController,
                          adjustCellHeight:
                              (int rowIndex, int colIndex, double newHeight) {
                            tableCubit.adjustCellHeight(
                                rowIndex, colIndex, newHeight);
                          },
                          adjustColumnWidth: (int colIndex, double newWidth) {
                            tableCubit.adjustColumnWidth(colIndex, newWidth);
                          },
                          adjustRowHeight: (int rowIndex, double newHeight) {
                            tableCubit.adjustRowHeight(rowIndex, newHeight);
                          },
                        ),
                      ),
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

class InteractiveTable extends StatelessWidget {
  final int rows;
  final int columns;
  final List<double> columnWidths;
  final List<double> rowHeights;
  final List<double> cellHeights;
  final ScrollController scrollController;
  final void Function(int rowIndex, int colIndex, double newHeight)
      adjustCellHeight;
  final void Function(int colIndex, double newWidth) adjustColumnWidth;
  final void Function(int rowIndex, double newHeight) adjustRowHeight;

  const InteractiveTable({
    required this.rows,
    required this.columns,
    required this.cellHeights,
    required this.columnWidths,
    required this.rowHeights,
    required this.scrollController,
    required this.adjustCellHeight,
    required this.adjustColumnWidth,
    required this.adjustRowHeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: columns > 1 ? Alignment.center : Alignment.centerRight,
      child: Scrollbar(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
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
                    behavior:
                        const ScrollBehavior().copyWith(scrollbars: false),
                    child: SingleChildScrollView(
                      primary: true,
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: List.generate(
                          rows,
                          (rowIndex) => Row(
                            children: List.generate(
                              columns,
                              (colIndex) => Stack(
                                children: [
                                  // Cell Content
                                  TableCellWidget(
                                    width: columnWidths[colIndex],
                                    height: rowHeights[rowIndex],
                                    rowIndex: rowIndex,
                                    colIndex: colIndex,
                                    adjustCellHeight: adjustCellHeight,
                                    adjustColumnWidth: adjustColumnWidth,
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
                      ),
                    ),
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

class TableCellWidget extends StatefulWidget {
  final double width;
  final double height;
  final int rowIndex;
  final int colIndex;
  final void Function(int rowIndex, int colIndex, double newHeight)
      adjustCellHeight;
  final void Function(int colIndex, double newWidth) adjustColumnWidth;

  const TableCellWidget({
    required this.width,
    required this.height,
    required this.rowIndex,
    required this.colIndex,
    required this.adjustCellHeight,
    required this.adjustColumnWidth,
    super.key,
  });

  @override
  TableCellWidgetState createState() => TableCellWidgetState();
}

class TableCellWidgetState extends State<TableCellWidget> {
  final TextEditingController _cellController = TextEditingController();
  // late double newHeight;

  // @override
  // void initState() {
  //   super.initState();
  //   newHeight = widget.height;
  //   log('before $newHeight');
  //   _cellController.addListener(_adjustHeight);
  // }

  // @override
  // void dispose() {
  //   _cellController.removeListener(_adjustHeight);
  //   _cellController.dispose();

  //   super.dispose();
  // }

  // void _adjustHeight() {
  //   final text = _cellController.text;
  //   final textPainter = TextPainter(
  //     text: TextSpan(
  //       text: text,
  //       style: AppFontStyles.bold16(context),
  //     ),
  //     textDirection: TextDirection.ltr,
  //   );
  //   textPainter.layout(maxWidth: widget.width - 16);
  //   newHeight = textPainter.size.height;
  //   widget.adjustCellHeight(widget.rowIndex, widget.colIndex, newHeight);
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: TextFormField(
              cursorColor: AppColors.black,
              contextMenuBuilder: (context, editableTextState) {
                final List<ContextMenuButtonItem> buttonItems = [
                  const ContextMenuButtonItem(onPressed: null, label: "حذف"),
                  const ContextMenuButtonItem(onPressed: null, label: "اضافة"),
                ];

                return AdaptiveTextSelectionToolbar.buttonItems(
                  anchors: editableTextState.contextMenuAnchors,
                  buttonItems: buttonItems,
                );
              },
              controller: _cellController,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              style: AppFontStyles.extraBold14(context)),
        ),
      ],
    );
  }
}
