class CellInTableModel {
  int? _backgroundColorHex;
  double? _fontSize;
  String? _content;

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
  set setFontSize(bool value) {
    if (_fontSize != null) {
      if (value) {
        _fontSize! < 36 ? _fontSize = _fontSize! + 1 : null;
      } else {
        _fontSize! > 2 ? _fontSize = _fontSize! - 1 : null;
      }
    }
  }
}

enum InsertType { addBelowRow, addAboveRow, addRightCol, addLeftCol }

enum RemoveType { removeEntireRow, removeEntireCol }

class InsertOrRemoveOptions {
  late bool _isActive;
  late InsertType _insertType;
  late RemoveType _removeType;
  InsertOrRemoveOptions(
      {bool isActive = false,
      InsertType insertType = InsertType.addBelowRow,
      RemoveType removeType = RemoveType.removeEntireCol}) {
    _isActive = isActive;
    _insertType = insertType;
    _removeType = removeType;
  }
  set setIsActive(bool value) {
    _isActive = value;
  }

  set setInsertType(InsertType value) {
    _insertType = value;
  }
  set setDeleteType(RemoveType value) {
    _removeType = value;
  }

  bool get getIsActive => _isActive;
  InsertType get getInsertType => _insertType;
  RemoveType get getRemoveType => _removeType;
}

List<InsertOrRemoveOptions> insertOptionList = [
  InsertOrRemoveOptions(insertType: InsertType.addBelowRow, isActive: true),
  InsertOrRemoveOptions(insertType: InsertType.addAboveRow, isActive: false),
  InsertOrRemoveOptions(insertType: InsertType.addRightCol, isActive: false),
  InsertOrRemoveOptions(insertType: InsertType.addLeftCol, isActive: false),
];
List<InsertOrRemoveOptions> removeOptionList = [
  InsertOrRemoveOptions(removeType: RemoveType.removeEntireRow, isActive: true),
  InsertOrRemoveOptions(removeType: RemoveType.removeEntireCol, isActive: false),
];
