import 'dart:developer';

import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/table_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/table_creation/custom_contex_menu.dart';
import 'package:flutter/material.dart';

class TableCellWidget extends StatelessWidget {
  final double width;
  final double height;
  final CellInTableModel cellItem;
  final void Function() changeColorValue;
  final void Function() changeFontValue;
  final void Function() insertNewRowOrCol;
  final void Function() deleteRowOrCol;

  const TableCellWidget({
    required this.width,
    required this.height,
    required this.cellItem,
    required this.changeColorValue,
    required this.changeFontValue,
    super.key,
    required this.insertNewRowOrCol,
    required this.deleteRowOrCol,
  });

  @override
  Widget build(BuildContext context) {
    log("rebuild");
    final TextEditingController controller =
        TextEditingController(text: cellItem.getContentofCell);
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: TextFormField(
              cursorColor: AppColors.black,
              contextMenuBuilder: (context, editableTextState) {
                return MyContextMenu(
                  anchor: editableTextState.contextMenuAnchors.primaryAnchor,
                  changeColorValue: changeColorValue,
                  changeFontValue: changeFontValue,
                  insertNewRowOrCol: insertNewRowOrCol,
                  deleteRowOrCol: deleteRowOrCol,
                );
              },
              onChanged: (value) {
                cellItem.setContentInCell = value;
              },
              maxLines: null,
              expands: true,
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(cellItem.getBackgroundColorHex ?? 0xfffffff),
                border: InputBorder.none,
              ),
              style: AppFontStyles.extraBold14(context)
                  .copyWith(fontSize: cellItem.getFontSize)),
        ),
      ],
    );
  }
}
