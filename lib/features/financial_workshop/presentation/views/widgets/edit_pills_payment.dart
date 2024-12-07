import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_ingradient.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/custom_edit_payment_item.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/app_bar_with_linking.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/style/app_colors.dart';

class EditPillPayment extends StatefulWidget {
  const EditPillPayment({super.key});

  @override
  State<EditPillPayment> createState() => _EditPillPaymentState();
}

class _EditPillPaymentState extends State<EditPillPayment> {
  final ScrollController controller = ScrollController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              const AppBarWithLinking(
                items: ["المرتبات", "تعديل"],
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.4,
                child: Scrollbar(
                  controller: controller,
                  scrollbarOrientation: ScrollbarOrientation.right,
                  thickness: 20,
                  thumbVisibility: true,
                  child: ScrollConfiguration(
                    behavior:ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                    child: ListView.separated(
                      controller: controller,
                        itemBuilder: (context, index) {
                          return const CustomEditPillItem();
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 16,
                          );
                        },
                        itemCount: 5),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: customLinearGradient(),
                ),
                child: const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.white,
                    )),
              ),
              Text(
                "إضافة موظف جديد",
                style: AppFontStyles.extraBoldNew20(context).copyWith(
                  color: AppColors.blue,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomPushContainerButton(
                    pushButtomText: "حفظ",
                    color: AppColors.green,
                    enableIcon: false,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    borderRadius: 12,
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  CustomPushContainerButton(
                    pushButtomText: "إلغاء",
                    color: AppColors.red,
                    enableIcon: false,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    borderRadius: 12,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
