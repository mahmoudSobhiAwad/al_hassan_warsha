import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/table_header.dart';
import 'package:flutter/material.dart';

class FullTableHeader extends StatelessWidget {
  const FullTableHeader({
    super.key,
    this.farzWidget,
  });
  final Widget? farzWidget;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Expanded(child:TableHeader()),
        const SizedBox(
          width: 14,
        ),
        farzWidget ??
            const Icon(
              Icons.new_label_outlined,
              color: Colors.white,
            ),
      ],
    );
  }
}
