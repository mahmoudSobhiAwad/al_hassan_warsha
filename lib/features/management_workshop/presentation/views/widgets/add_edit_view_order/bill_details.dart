import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/selected_payment_way.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BillDetails extends StatelessWidget {
  const BillDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text("الفاتورة",style: AppFontStyles.extraBold24(context),),
         const SizedBox(height: 10,),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 10.0),
           child: Row(
            children: [
              Expanded(flex: 2,child: CustomColumnWithTextInAddNewType(text: "المبلغ الكلي", textLabel: "",textStyle: AppFontStyles.extraBold18(context),enableBorder: true,suffixIcon: Text("جنية",style: AppFontStyles.extraBold18(context),),)),
              const Expanded(flex: 1,child: SizedBox()),
              Expanded(flex: 2,child: CustomColumnWithTextInAddNewType(text: "المقدم ", textLabel: "",textStyle: AppFontStyles.extraBold18(context),enableBorder: true,suffixIcon: Text("جنية",style: AppFontStyles.extraBold18(context),),)),
              const Expanded(flex: 1,child: SizedBox()),
              const Expanded(flex: 3,child: SelectedPaymentWay()),
              const Expanded(child: SizedBox()),
              Expanded(flex: 2,child: CustomColumnWithTextInAddNewType(text: "عدد الدفعات", textLabel: "",textStyle: AppFontStyles.extraBold18(context),enableBorder: true,suffixIcon: const Icon(Icons.add_circle_outlined,size: 40,),prefixIcon:const Icon(CupertinoIcons.minus_circle_fill,color: Colors.black,size: 40,),)),
            ],
           ),
         )
      ],
    );
  }
}