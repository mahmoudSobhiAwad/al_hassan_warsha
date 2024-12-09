import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:flutter/material.dart';

class AddNewOrderButton extends StatelessWidget {
  const AddNewOrderButton({
    super.key,
    required this.formKey,
    required this.addOrder,
    required this.isLoading,
    this.textStyle,
    this.edgeInsets,
  });

  final GlobalKey<FormState> formKey;
  final void Function() addOrder;
  final bool isLoading;
  final TextStyle? textStyle;
  final EdgeInsets? edgeInsets;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: CustomPushContainerButton(
      padding: edgeInsets,
      onTap: () {
        if (formKey.currentState!.validate()) {
          addOrder();
        }
      },
      childInstead: isLoading
          ? const CircularProgressIndicator(
              color: AppColors.white,
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "اضافة ",
                  style: textStyle ??
                      AppFontStyles.extraBoldNew24(context).copyWith(
                        color: AppColors.white,
                      ),
                ),
                const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.add,
                      color: AppColors.white,
                      size: 30,
                    ))
              ],
            ),
      enableIcon: false,
      borderRadius: 16,
    ));
  }
}
