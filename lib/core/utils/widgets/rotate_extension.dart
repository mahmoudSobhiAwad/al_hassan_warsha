

import 'dart:math';

import 'package:flutter/widgets.dart';

extension RotateIcon on Widget {
  Widget rotate({required double angle}) => Transform.rotate(
        angle: (angle * pi) / 180,
        child: this,
      );
}