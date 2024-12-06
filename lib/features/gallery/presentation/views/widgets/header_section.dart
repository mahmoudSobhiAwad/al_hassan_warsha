import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_dialog_add_new_type.dart';
import 'package:flutter/material.dart';

class HeaderSetionInGallery extends StatelessWidget {
  const HeaderSetionInGallery({
    super.key,
    required this.addType,
    required this.formKey,
    required this.controller,
    this.openCloseSideBar,
  });
  final void Function() addType;
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final Widget?openCloseSideBar;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          openCloseSideBar??const SizedBox(),
          
          CustomPushContainerButton(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => Form(
                        key: formKey,
                        child: AddNewTypeDialog(
                          add: () {
                            if (formKey.currentState!.validate() &&
                                controller.text.trim().isNotEmpty) {
                              addType();
                            }
                          },
                          controller: controller,
                          formKey: formKey,
                        ),
                      ));
            },
            pushButtomText: "إضافة جديد",
          ),
          const SizedBox(height: 14),
          const Divider(
            color: AppColors.lightGray1,
            thickness: 5,
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}
