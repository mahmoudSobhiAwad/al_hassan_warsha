import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/kitchen_item_type.dart';
import 'package:flutter/material.dart';

class ListOfKitchenTypes extends StatelessWidget {
  const ListOfKitchenTypes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: 50,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return const KitchenTypeItem();
      },
    );
  }
}


