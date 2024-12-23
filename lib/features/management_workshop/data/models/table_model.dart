class CellInTableModel {
  int? _backgroundColorHex;
  double? _fontSize;
  String? _content;
  // Getter for backgroundColorHex
  CellInTableModel() {
    _backgroundColorHex = 0xfffffff;
    _fontSize = 16;
    _content = "";
  }
  int? get getBackgroundColorHex => _backgroundColorHex;

  // Setter for backgroundColorHex
  set setBackgroundColorHex(int? value) {
    if (value != null) _backgroundColorHex = value;
  }

  // Getter for backgroundColorHex
  String? get getContentofCell => _content;

  // Setter for backgroundColorHex
  set setContentInCell(String? value) {
    if (value != null) _content = value;
  }

  // Getter for fontSize
  double? get getFontSize => _fontSize;

  // Setter for fontSize
  set setFontSize(double? value) {
    if (value != null) _fontSize = value;
  }
}
