
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';

class SelectedPaymentWay extends StatelessWidget {
  const SelectedPaymentWay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("المبلغ المتبقي",style: AppFontStyles.extraBold18(context),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    
                    fit: FlexFit.loose,
                    child: Text("الدفع عند الاستلام",style: AppFontStyles.extraBold18(context),)),
                  const IconButton(onPressed: null, icon: Icon(Icons.check_box_outline_blank_rounded))
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Text("الدفع علي دفعات",style: AppFontStyles.extraBold18(context),)),
                  const IconButton(onPressed: null, icon: Icon(Icons.check_box_outlined))
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}