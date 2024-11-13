import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("تفاصيل الطلب",style: AppFontStyles.extraBold24(context),),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(flex: 2,child: CustomColumnWithTextInAddNewType(text: "اسم المطبخ",enableBorder: true,textStyle: AppFontStyles.extraBold18(context), textLabel: "")),
                  const Expanded(child: SizedBox()),
                  Expanded(flex: 3,child: CustomColumnWithTextInAddNewType(text: "اللون المطلوب",enableBorder: true,textStyle: AppFontStyles.extraBold18(context), textLabel: "حدد اسم اللون او اختار الدرجة المناسبة",suffixIcon: const Icon(Icons.color_lens_rounded),)),
                  const Expanded(child: SizedBox()),
                  Expanded(flex: 2,child: CustomColumnWithTextInAddNewType(text: "نوع المطبخ ",enableBorder: true,textStyle: AppFontStyles.extraBold18(context), textLabel: "",suffixIcon: const Icon(Icons.expand_more_outlined),)),
                  const Expanded(child: SizedBox()),
                  Expanded(flex: 2,child: CustomColumnWithTextInAddNewType(text: " تاريخ الاستلام ",enableBorder: true,textStyle: AppFontStyles.extraBold18(context), textLabel: "",suffixIcon: const Icon(Icons.calendar_month_rounded),)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CustomColumnWithTextInAddNewType(text: "ملاحظات", textLabel: "",enableBorder: true,maxLine: 4,textStyle: AppFontStyles.extraBold18(context),),
              const SizedBox(
                height: 10,
              ),
              Text("الوسائط",style: AppFontStyles.extraBold18(context),),
              const SizedBox(
                height: 10,
              ),
              /// incase of there are media 
              // SizedBox(
              //   height: MediaQuery.sizeOf(context).height*0.2,
              //   child: const ListOfOneKitchenType(enableInner:false,enableClose: true,)),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  color: AppColors.veryLightGray,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text("ارفع بعض الصور ومقاطع الفيديو الخاصة بالمنتج ",style: AppFontStyles.extraBold28(context),),
                      const Icon(Icons.cloud_upload,size: 40,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
