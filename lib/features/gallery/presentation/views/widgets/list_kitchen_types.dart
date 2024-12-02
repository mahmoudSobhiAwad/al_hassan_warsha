import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_type.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/kitchen_item_type.dart';
import 'package:flutter/material.dart';

class ListOfKitchenTypes extends StatelessWidget {
  const ListOfKitchenTypes(
      {super.key,
      required this.kitchenTypesList,
      required this.onTap,
      required this.currIndex});
  final List<OnlyTypeModel> kitchenTypesList;
  final void Function(int index) onTap;
  final int currIndex;
  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: kitchenTypesList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return KitchenTypeItem(
          index: index,
          onTap: (index) {
            onTap(index);
          },
          picked: currIndex == index,
          model: kitchenTypesList[index],
        );
      },
    );
  }
}
