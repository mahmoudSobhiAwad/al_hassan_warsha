import 'dart:ui';

class TableData {
  int rows;
  int columns;
  List<List<String>> data;
  double titleFontSize;
  double contentFontSize;
  Color titleBackgroundColor;

  TableData({
    required this.rows,
    required this.columns,
    this.titleFontSize = 18,
    this.contentFontSize = 16,
    this.titleBackgroundColor=const Color(0xffffffff),
    this.data = const [],
  });
}
