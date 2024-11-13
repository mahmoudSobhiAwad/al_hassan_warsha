import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/table_header.dart';
import 'package:flutter/material.dart';

class FullTableHeader extends StatelessWidget {
  const FullTableHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
     mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(child: TableHeader()),
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



