import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:flutter/material.dart';

class ExpandedDivider extends StatelessWidget {
  const ExpandedDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
     mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(child: Divider(
          color: AppColors.lightGray1,
          thickness: 2,
        )),
        SizedBox(
          width: 14,
        ),
        Icon(
          Icons.new_label_outlined,
          color: Colors.white,
        ),
      ],
    );
  }
}
