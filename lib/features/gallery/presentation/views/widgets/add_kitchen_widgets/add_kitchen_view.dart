import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/view_edit_add_bloc/bloc/view_edit_add_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/empyt_upload_media.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:flutter/material.dart';

class AddKitchenView extends StatefulWidget {
  const AddKitchenView(
      {super.key,
      required this.bloc,
      required this.typeId,
      this.kitchenModel,
      this.enableEdit = false});
  final ViewEditAddBloc bloc;
  final String? typeId;
  final KitchenModel?kitchenModel;
  final bool enableEdit;

  @override
  State<AddKitchenView> createState() => _AddKitchenViewState();
}

class _AddKitchenViewState extends State<AddKitchenView> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController describController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    controller.dispose();
    describController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.text = widget.kitchenModel?.kitchenName??"";
    describController.text = widget.kitchenModel?.kitchenDesc??"";
    final double width = MediaQuery.sizeOf(context).width;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: width * 0.5,
              child: CustomColumnWithTextInAddNewType(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "الاسم لا يمكن ان يكون خاليا ";
                  }
                  return null;
                },
                controller: controller,
                textStyle: AppFontStyles.extraBold25(context),
                text: "الاسم",
                textLabel: "اضف اسم للمنتج................",
                enableBorder: true,
              )),
          const SizedBox(
            height: 12,
          ),
          CustomColumnWithTextInAddNewType(
            controller: describController,
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
          Center(
              child: CustomPushContainerButton(
            onTap: () {
              if (formKey.currentState!.validate()) {
                if (! widget.enableEdit) {
                  widget.bloc.add(AddNewKitchenEvent(
                      typeId: widget.typeId ?? "",
                      name: controller.text,
                      desc: describController.text));
                }
                else{
                  widget.kitchenModel?.kitchenName=controller.text;
                  widget.kitchenModel?.kitchenDesc=describController.text;
                  widget.bloc.add(EditKitchenEvent(model: widget.kitchenModel!));
                }
                controller.clear();
                describController.clear();
              }
            },
            pushButtomText: widget.enableEdit ? "تعديل" : "إضافة",
            borderRadius: 15,
            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 12),
            enableIcon: false,
          )),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
