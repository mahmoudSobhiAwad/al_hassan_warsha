import 'package:al_hassan_warsha/core/utils/functions/extentions.dart';
import 'package:flutter/material.dart';

double getResponiveFontSize(BuildContext context,
    {required double baseFontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = scaleFactor * baseFontSize;
  double minWidth = 0.8 * baseFontSize;
  double maxWidth = 1.2 * baseFontSize;
  return responsiveFontSize.clamp(minWidth, maxWidth);
}

double getScaleFactor(BuildContext context) {
  double screenWidth = context.screenWidth;
  if (screenWidth < 500) {
    return screenWidth / 400;
  } else if (screenWidth < 1024) {
    return screenWidth / 600;
  } else {
    return screenWidth / 1600;
  }
}
