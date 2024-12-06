import 'package:al_hassan_warsha/features/home/data/home_data.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/home_box_item.dart';
import 'package:flutter/material.dart';

class HomeItemsList extends StatelessWidget {
  const HomeItemsList({super.key, required this.onTap, this.textStyle});
  final void Function(int) onTap;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ...List.generate(
          homeModelList.length,
          (index) => HomeItem(
            textStyle: textStyle,
            onTap: () {
              onTap(index);
            },
            homeModel: homeModelList[index],
          ),
        ),
      ],
    );
  }
}
