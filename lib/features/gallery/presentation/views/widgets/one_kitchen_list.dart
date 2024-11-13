import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/small_kitchen_image.dart';
import 'package:flutter/material.dart';

class ListOfOneKitchenType extends StatelessWidget {
  const ListOfOneKitchenType({super.key,this.enableInner=true,this.enableClose=false});
  final bool enableInner;
  final bool enableClose;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return SmallKitchenTypeImage(widthOfImage: 0.3,enableInner: enableInner,enableClose: enableClose,);
          },
          separatorBuilder: (context, index) => const SizedBox(
                width: 14,
              ),
          itemCount: 20),
    );
  }
}
