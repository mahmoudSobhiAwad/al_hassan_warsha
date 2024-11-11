import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/table_header.dart';
import 'package:flutter/material.dart';

class FullTableHeader extends StatelessWidget {
  const FullTableHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                TableHeader(),
                Expanded(
                    child: Divider(
                  color: AppColors.lightGray1,
                  height: 1,
                )),
              ],
            ),
          ),
          SizedBox(
            width: 14,
          ),
          Icon(
            Icons.new_label_outlined,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
