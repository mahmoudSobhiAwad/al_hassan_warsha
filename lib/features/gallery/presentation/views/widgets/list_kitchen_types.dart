import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_type.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/kitchen_item_type.dart';
import 'package:flutter/material.dart';

class ListOfKitchenTypes extends StatelessWidget {
  const ListOfKitchenTypes({
    super.key,
    required this.kitchenTypesList
  });
  final List<KitchenTypeModel>kitchenTypesList;
  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: kitchenTypesList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return KitchenTypeItem(model: kitchenTypesList[index],);
      },
    );
  }
}


