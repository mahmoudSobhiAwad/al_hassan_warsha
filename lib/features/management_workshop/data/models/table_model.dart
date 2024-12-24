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

class InsertOption {
  bool _isActive;
  InsertType _insertType;
  InsertOption(this._insertType, this._isActive);
  set setIsActive(bool value){
    _isActive=value;
  }
  set setInsertType(InsertType value){
    _insertType=value;
  }
  bool get getIsActive =>_isActive;
  InsertType get getInsertType =>_insertType;
}

List<InsertOption>insertOptionList=[
  InsertOption(InsertType.addBelowRow, true),
  InsertOption(InsertType.addAboveRow, false),
  InsertOption(InsertType.addRightCol, false),
  InsertOption(InsertType.addLeftCol, false),
];