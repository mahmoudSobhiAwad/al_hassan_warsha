import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/action_types_in_dialog.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_box_shadow.dart';
import 'package:flutter/material.dart';

class AlertCheckOfDataBase extends StatelessWidget {
  const AlertCheckOfDataBase({super.key,this.onPressed_2});
  final void Function()?onPressed_2;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width*0.5,
         
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              customLowBoxShadow(),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "لا يوجد اي قاعدة بيانات حالية لديك هل لديك بيانات تود استراجعها ؟",
              style: AppFontStyles.extraBold40(context),
              textAlign: TextAlign.center,
            ),
            const IconButton(
              onPressed: null,
              icon: Icon(
                Icons.warning,
                color: AppColors.orange,
                size: 70,
              ),
            ),
            DialogAddNewTypeActionButton(
              color_1: AppColors.green,
              color_2: AppColors.blue,
              text_1: "استرجاع",
              text_2: "إنشاء جديد",
              onPressed_2: onPressed_2,
              onPressed_1: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
