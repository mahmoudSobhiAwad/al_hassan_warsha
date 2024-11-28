import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_ingradient.dart';
import 'package:flutter/material.dart';

class AppBarWithLinking extends StatelessWidget {
  const AppBarWithLinking(
      {super.key, this.onBack, required this.items, this.enableColor = true});
  final void Function()? onBack;
  final List<String> items;
  final bool enableColor;
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
              size: 38,
            ),
            alignment: Alignment.center,
          ),
          const SizedBox(
            width: 24,
          ),
          Expanded(
            child: Row(
              children: [
                ...List.generate(
                    items.length,
                    (index) => CustomItemInCustomLinkingAppBar(
                      enableColor: enableColor,
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

class CustomItemInCustomLinkingAppBar extends StatelessWidget {
  const CustomItemInCustomLinkingAppBar(
      {super.key, required this.text, this.isLast = false,this.enableColor=true});
  final String text;
  final bool isLast;
  final bool enableColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.2,
          ),
          child: Text(
            text,
            style: AppFontStyles.extraBold40(context)
                .copyWith(color: enableColor ? AppColors.white : AppColors.black,),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        isLast
            ?  IconButton(
                onPressed: null,
                icon: Icon(
                  color: enableColor ? AppColors.white : AppColors.black,
                  Icons.arrow_forward_ios_rounded,
                  size: 40,
                ))
            : const SizedBox(),
      ],
    );
  }
}
