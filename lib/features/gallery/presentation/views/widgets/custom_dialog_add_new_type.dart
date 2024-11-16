import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/action_types_in_dialog.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:flutter/material.dart';

class AddNewTypeDialog extends StatelessWidget {
  const AddNewTypeDialog({super.key,required this.controller,required this.add,required this.formKey});
  final void Function()?add;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        child: Container(
          constraints: BoxConstraints(maxWidth: width * 0.75),
          padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 36),
          decoration: BoxDecoration(
              color: AppColors.veryLightGray,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               CustomColumnWithTextInAddNewType(
                validator: (value){
                  if(value==null||value.isEmpty){
                    return " اسم النوع لا يمكن ان يكون خاليا";
                  }
                  return null;
                },
                formKey: formKey,
                controller: controller,
                text: "اسم النوع",
                textLabel: "ادخل نوع المطبخ الجديد.............",
              ),
              const SizedBox(
                height: 24,
              ),
              DialogAddNewTypeActionButton(
                onPressed_1: add,
                onPressed_2: (){
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}



