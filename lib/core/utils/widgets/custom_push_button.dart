import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_ingradient.dart';
import 'package:flutter/material.dart';

class CustomPushContainerButton extends StatelessWidget {
  const CustomPushContainerButton({super.key,this.pushButtomText});
final String ?pushButtomText;
  @override
  Widget build(BuildContext context) {
    return   Container(
                padding:const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(25),
                  gradient: customLinearGradient(),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      //fit: BoxFit.scaleDown,
                      child: Text(pushButtomText??"إضافة نوع جديد",style: AppFontStyles.extraBold30(context).copyWith(color: AppColors.white,),)),
                    const SizedBox(width: 16,),
                    const Icon(Icons.add,color: Colors.white,size: 50,)
                  ],
                ),
              );
  }
}