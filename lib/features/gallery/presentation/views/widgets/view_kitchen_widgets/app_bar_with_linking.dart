import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_ingradient.dart';
import 'package:flutter/material.dart';

class AppBarWithLinking extends StatelessWidget {
  const AppBarWithLinking({super.key, this.onBack, required this.items});
  final void Function()? onBack;
  final List<String> items;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: customLinearGradient(),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack ?? () => Navigator.pop(context),
            icon: const Icon(
               color: AppColors.white,
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
      {super.key, required this.text, this.isLast = false});
  final String text;
  final bool isLast;
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
                .copyWith(color: AppColors.white),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        isLast
            ? const IconButton(
                onPressed: null,
                icon: Icon(
                   color: AppColors.white,
                  Icons.arrow_forward_ios_rounded,
                  size: 40,
                ))
            : const SizedBox(),
      ],
    );
  }
}
