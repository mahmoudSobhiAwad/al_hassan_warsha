import 'package:flutter/widgets.dart';

extension MediaQueryValues on BuildContext {
  double get screenHeight => MediaQuery.sizeOf(this).height;
  double get screenWidth => MediaQuery.sizeOf(this).width;
}
