import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_text_form_field.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_dialog_add_new_type.dart';
import 'package:flutter/material.dart';

class HeaderSetionInGallery extends StatefulWidget {
  const HeaderSetionInGallery({
    super.key,
    required this.addType,
  });
  final void Function(String) addType;

  @override
  State<HeaderSetionInGallery> createState() => _HeaderSetionInGalleryState();
}

class _HeaderSetionInGalleryState extends State<HeaderSetionInGallery> {
  final TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          CustomTextFormField(
            borderRadius: 16,
            enableBorder: false,
            fillColor: AppColors.white,
            suffixWidget: const IconButton(
              onPressed: null,
              icon: Icon(Icons.search),
              iconSize: 40,
              color: AppColors.black,
            ),
            labelWidget: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "ابحث عن شئ معين.......",
                style: AppFontStyles.extraBold20(context)
                    .copyWith(color: AppColors.lightGray1),
              ),
            ),
          ),
          const SizedBox(height: 30),
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
                              widget.addType(controller.text);
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
