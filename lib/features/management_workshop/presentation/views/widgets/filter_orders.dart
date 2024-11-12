import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/rotate_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterOrdersWithMonthYear extends StatelessWidget {
  const FilterOrdersWithMonthYear({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      
      children: [
        const Expanded( child: SizedBox()),
        Text(
          "الطلبات الحالية ل",
          style: AppFontStyles.extraBold40(context),
        ),
        const Expanded(flex: 5, child: SizedBox()),
        CustomContainerToPickHistory(
          child: Row(
            children: [
              Text(
                "أكتوبر",
                style: AppFontStyles.extraBold20(context),
              ),
              IconButton(
                  onPressed: () {},
                  icon:
                      const Icon(Icons.arrow_back_ios_new).rotate(angle: 90))
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
        CustomContainerToPickHistory(
          child: Row(
            children: [
              Text(
                "2024",
                style: AppFontStyles.extraBold20(context),
              ),
              IconButton(
                  onPressed: () {}, icon: const Icon(CupertinoIcons.calendar))
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}

class CustomContainerToPickHistory extends StatelessWidget {
  const CustomContainerToPickHistory({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
      decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.lightGray1, width: 2),
          borderRadius: BorderRadius.circular(12)),
      child: child,
    );
  }
}
