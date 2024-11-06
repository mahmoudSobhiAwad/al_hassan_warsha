import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/action_types_in_dialog.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:flutter/material.dart';

class AddNewTypeDialog extends StatelessWidget {
  const AddNewTypeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        child: Container(
          constraints: BoxConstraints(maxWidth: width * 0.75),
          padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 12),
          decoration: BoxDecoration(
              color: AppColors.veryLightGray,
              borderRadius: BorderRadius.circular(20)),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomColumnWithTextInAddNewType(
                text: "اسم النوع",
                textLabel: "ادخل نوع المطبخ الجديد.............",
              ),
              SizedBox(
                height: 24,
              ),
              CustomColumnWithTextInAddNewType(
                text: "تفاصيل",
                textLabel: "ادخل وصف اللمطبخ الجديد.............",
              ),
              SizedBox(
                height: 24,
              ),
              DialogAddNewTypeActionButton()
            ],
          ),
        ),
      ),
    );
  }
}



