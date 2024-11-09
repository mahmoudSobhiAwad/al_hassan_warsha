import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_ingradient.dart';
import 'package:flutter/material.dart';

class CustomPushContainerButton extends StatelessWidget {
  const CustomPushContainerButton({super.key, this.borderRadius,this.padding,this.pushButtomText,this.onTap,this.enableIcon=true,this.color,this.iconBehind});
  final String? pushButtomText;
  final void Function()?onTap;
  final bool enableIcon;
  final Color?color;
  final EdgeInsets?padding;
  final IconData?iconBehind;
  final double?borderRadius;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding:padding?? const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: color,
            gradient: color ==null? customLinearGradient():null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  //fit: BoxFit.scaleDown,
                  child: Text(
                pushButtomText ?? "إضافة نوع جديد",
                style: AppFontStyles.extraBold30(context).copyWith(
                  color: AppColors.white,
                ),
              )),
               enableIcon?const SizedBox(
                width: 16,
              ):const SizedBox(),
              enableIcon?Icon(
                iconBehind?? Icons.add,
                color: Colors.white,
                size: 50,
              ):const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
