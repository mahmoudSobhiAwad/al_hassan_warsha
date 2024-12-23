import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/table_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/table_creation/custom_contex_menu.dart';
import 'package:flutter/material.dart';

class TableCellWidget extends StatefulWidget {
  final double width;
  final double height;
  final int rowIndex;
  final int colIndex;
  final CellInTableModel cellItem;
  final void Function(int)changeColorValue;

  const TableCellWidget({
    required this.width,
    required this.height,
    required this.rowIndex,
    required this.colIndex,
    required this.cellItem,
    required this.changeColorValue,
    super.key,
  });

  @override
  TableCellWidgetState createState() => TableCellWidgetState();
}

class TableCellWidgetState extends State<TableCellWidget> {
  final TextEditingController _cellController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _cellController.text = widget.cellItem.getContentofCell ?? "";
  }

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
                return MyContextMenu(
                  anchor: editableTextState.contextMenuAnchors.primaryAnchor,
                  changeColorValue: (int value) {
                    widget.changeColorValue(value);
                  },
                );
              },
              controller: _cellController,
              onChanged: (value) {
                widget.cellItem.setContentInCell = value;
              },
              maxLines: null,
              expands: true,
              decoration: InputDecoration(
                filled: true,
                fillColor:
                    Color(widget.cellItem.getBackgroundColorHex ?? 0xfffffff),
                border: InputBorder.none,
              ),
              style: AppFontStyles.extraBold14(context)),
        ),
      ],
    );
  }
}
