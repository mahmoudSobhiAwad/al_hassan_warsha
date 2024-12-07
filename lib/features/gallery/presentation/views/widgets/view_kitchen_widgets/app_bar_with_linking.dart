import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_ingradient.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/custom_item_in_app_bar_with_linking.dart';
import 'package:flutter/material.dart';

class AppBarWithLinking extends StatelessWidget {
  const AppBarWithLinking(
      {super.key, this.onBack, required this.items,this.iconSize ,this.enableColor = true,this.fontSize});
  final void Function()? onBack;
  final List<String> items;
  final bool enableColor;
  final double ?fontSize;
  final double?iconSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: enableColor
          ? BoxDecoration(
              gradient: customLinearGradient(),
            )
          : null,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack ?? () => Navigator.pop(context),
            icon: Icon(
              color: enableColor ? AppColors.white : AppColors.black,
              Icons.arrow_back_ios_rounded,
              size:iconSize?? 38,
            ),
            alignment: Alignment.center,
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Row(
              children: [
                ...List.generate(
                    items.length,
                    (index) => CustomItemInCustomLinkingAppBar(
                      enableColor: enableColor,
                      fontSize: fontSize,
                          text: items[index],
                          isLast: index != items.length - 1,
                        )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

