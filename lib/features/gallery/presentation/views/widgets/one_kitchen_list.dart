import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/small_kitchen_image.dart';
import 'package:flutter/material.dart';

class ListOfOneKitchenType extends StatelessWidget {
  const ListOfOneKitchenType({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return const SmallKitchenTypeImage();
          },
          separatorBuilder: (context, index) => const SizedBox(
                width: 14,
              ),
          itemCount: 20),
    );
  }
}
