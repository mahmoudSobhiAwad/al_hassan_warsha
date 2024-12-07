import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_ingradient.dart';
import 'package:flutter/material.dart';

class CustomPushContainerButton extends StatelessWidget {
  const CustomPushContainerButton(
      {super.key,
      this.iconSize,
      this.pushButtomTextFontSize,
      this.childInstead,
      this.borderRadius,
      this.padding,
      this.pushButtomText,
      this.onTap,
      this.enableIcon = true,
      this.color,
      this.iconBehind});
  final String? pushButtomText;
  final double? pushButtomTextFontSize;
  final void Function()? onTap;
  final bool enableIcon;
  final Color? color;
  final EdgeInsets? padding;
  final IconData? iconBehind;
  final double? borderRadius;
  final Widget? childInstead;
  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.white,
      highlightColor: Colors.white,
      focusColor: Colors.white,
      splashColor: Colors.white,
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 25),
          color: color,
          gradient: color == null ? customLinearGradient() : null,
        ),
        child: childInstead ??
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    child: Text(
                  pushButtomText ?? "إضافة نوع جديد",
                  style: AppFontStyles.extraBoldNew24(context).copyWith(
                    fontSize: pushButtomTextFontSize,
                    color: AppColors.white,
                  ),
                )),
                enableIcon
                    ? const SizedBox(
                        width: 16,
                      )
                    : const SizedBox(),
                enableIcon
                    ? Icon(
                        iconBehind ?? Icons.add,
                        color: Colors.white,
                        size: iconSize ?? 50,
                      )
                    : const SizedBox()
              ],
            ),
      ),
    );
  }
}
