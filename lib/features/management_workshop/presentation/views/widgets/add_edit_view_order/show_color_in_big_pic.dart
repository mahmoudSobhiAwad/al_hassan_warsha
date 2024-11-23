import 'package:flutter/material.dart';

Future<dynamic> showColorInBigMood(BuildContext context, Color color) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ));
}

