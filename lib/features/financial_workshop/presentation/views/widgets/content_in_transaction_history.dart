import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_text_style_in_header.dart';
import 'package:flutter/material.dart';

class ContentInTransactionHistory extends StatelessWidget {
  const ContentInTransactionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding:const EdgeInsets.symmetric(vertical: 12,horizontal: 5),
      decoration: BoxDecoration(
        boxShadow:const [
           BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 7.5,
            color: AppColors.blackOpacity20
          )
        ],
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
      
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 4,
              child: CustomTextWithTheSameStyle(
                textStyle: AppFontStyles.extraBold18(context),
            text: "شراء بضاعة لمطبخ الحاج محمد ابو احمد",
          )),
          const Expanded(child: SizedBox()),
          Expanded(
              flex:2,
              child: CustomTextWithTheSameStyle(
                textStyle: AppFontStyles.extraBold18(context),
                text: "20000 جنية",
              )),
          const Expanded(child: SizedBox()),
          Expanded(
              flex: 2,
              child: CustomTextWithTheSameStyle(
                textStyle: AppFontStyles.extraBold18(context),
                text: "13 نوفمبر 2024",
              )),
          const Expanded(child: SizedBox()),
          Expanded(
              flex: 2,
              child: Center(
                child: CustomTextWithTheSameStyle(
                  textStyle: AppFontStyles.extraBold18(context),
                  
                  text: "تحويل بنكي",
                ),
              )),
          const Expanded(child: SizedBox()),
          Expanded(
              flex: 2,
              child: Center(
                child: CustomTextWithTheSameStyle(
                  textStyle: AppFontStyles.extraBold18(context),
                  text: "استلام",
                ),
              )),
          const Expanded(child: SizedBox()),
          
        ],
      ),
    );
  }
}
