import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';

class AppBarWithLinking extends StatelessWidget {
  const AppBarWithLinking({super.key, this.onBack,required this.items});
  final void Function()? onBack;
  final List<String>items;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.veryLightGray,
          ),
          child: IconButton(
            onPressed: onBack ?? () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              size: 38,
            ),
            alignment: Alignment.center,
          ),
        ),
        const SizedBox(
          width: 24,
        ),
        Expanded(
          flex: 10,
          child: Row(
            children: [
              ...List.generate(items.length, (index)=>CustomItemInCustomLinkingAppBar(text: items[index],isLast: index!=items.length-1,)),
            ],
          ),
        ),
      ],
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
            maxWidth:MediaQuery.sizeOf(context).width*0.15,
          ),
          child: Text(
            text,
            style: AppFontStyles.extraBold40(context),
            overflow:TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        isLast
            ? const IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 40,
                ))
            : const SizedBox(),
      ],
    );
  }
}
