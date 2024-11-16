import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/empyt_upload_media.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:flutter/material.dart';

class AddKitchenView extends StatelessWidget {
  const AddKitchenView({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: width * 0.5,
            child: CustomColumnWithTextInAddNewType(
              textStyle: AppFontStyles.extraBold25(context),
              text: "الاسم",
              textLabel: "اضف اسم للمنتج................",
              enableBorder: true,
            )),
        const SizedBox(
          height: 12,
        ),
        CustomColumnWithTextInAddNewType(
          textStyle: AppFontStyles.extraBold25(context),
          maxLine: 2,
          text: "الوصف",
          textLabel:
              "اضف بعض الوصف للمنتج ليساعدك في شرح المنتج للعميل...................",
          enableBorder: true,
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          "الوسائط",
          style: AppFontStyles.extraBold25(context),
        ),
        const EmptyUploadMedia(),
        const SizedBox(
          height: 24,
        ),
        
        const Center(
            child: CustomPushContainerButton(
          pushButtomText: "إضافة",
          borderRadius: 15,
          padding: EdgeInsets.symmetric(horizontal: 70, vertical: 12),
          enableIcon: false,
        )),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}

