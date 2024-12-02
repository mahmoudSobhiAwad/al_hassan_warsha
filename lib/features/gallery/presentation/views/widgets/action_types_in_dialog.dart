import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:flutter/material.dart';

class DialogAddNewTypeActionButton extends StatelessWidget {
  const DialogAddNewTypeActionButton({super.key,this.color_1,this.instead_1,this.color_2,this.text_1,this.text_2,this.onPressed_1,this.onPressed_2});
  final String? text_1;
  final String? text_2;
  final Color? color_1;
  final Color? color_2;
  final void Function()?onPressed_1;
  final void Function()?onPressed_2;
  final Widget?instead_1;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      
      children: [
        Flexible(
          child: CustomPushContainerButton(
            onTap: onPressed_1,
            borderRadius: 16,
            padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 12),
            pushButtomText:text_1?? "إضافة",
            childInstead: instead_1,
            color: color_1?? AppColors.green,
            enableIcon: false,
          ),
        ),
        const SizedBox(
          width: 36,
        ),
        Flexible(
          child: CustomPushContainerButton(
            onTap: onPressed_2,
            borderRadius: 16,
            padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 12),
            pushButtomText:text_2?? "إلغاء",
            color:color_2?? AppColors.red,
            enableIcon: false,
          ),
        ),
      ],
    );
  }
}
