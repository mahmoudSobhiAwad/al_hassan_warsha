import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_text_style_in_header.dart';
import 'package:flutter/material.dart';

class HeaderForTransactionHistory extends StatelessWidget {
  const HeaderForTransactionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          children: [
            const Expanded(child: SizedBox()),
            Expanded(
               flex: 12,
              child:  Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 4,
                      child: CustomTextWithTheSameStyle(
                        textStyle: AppFontStyles.extraBold18(context),
                    text: "المعاملة",
                  )),
                  const Expanded(child: SizedBox()),
                  Expanded(
                      flex:2,
                      child: CustomTextWithTheSameStyle(
                        textStyle: AppFontStyles.extraBold18(context),
                        text: "قيمة المعاملة",
                      )),
                  const Expanded(child: SizedBox()),
                  Expanded(
                      flex: 2,
                      child: CustomTextWithTheSameStyle(
                        textStyle: AppFontStyles.extraBold18(context),
                        text: "تاريخ المعاملة",
                      )),
                  const Expanded(child: SizedBox()),
                  Expanded(
                      flex: 2,
                      child: CustomTextWithTheSameStyle(
                        textStyle: AppFontStyles.extraBold18(context),
                        
                        text: "طريقة المعاملة",
                      )),
                  const Expanded(child: SizedBox()),
                  Expanded(
                      flex: 2,
                      child: CustomTextWithTheSameStyle(
                        textStyle: AppFontStyles.extraBold18(context),
                        text: "دفع/ استلام",
                      )),
                  const Expanded(child: SizedBox()),
                  
                ],
              ),
            ),
             const Expanded(
              
              child: SizedBox(
                width: 12,
              ),
            ),
          ],
        ),
        const Row(
          
          children: [
            Expanded(child: SizedBox()),
            Expanded(
              flex: 12,
              child: Divider(
                    
                    thickness: 2,
                  ),
            ),
            Expanded(child: SizedBox())
          ],
        ),
      ],
    );
  }
}