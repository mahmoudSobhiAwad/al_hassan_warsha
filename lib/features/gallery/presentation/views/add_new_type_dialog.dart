import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_dialog_add_new_type.dart';
import 'package:flutter/material.dart';

Future<dynamic> showDialogToAddNewKitchenType(BuildContext context,
    {required GlobalKey<FormState> formKey,
    required TextEditingController controller,
    required void Function() add}) {
  return showDialog(
      context: context,
      builder: (context) => Form(
            key: formKey,
            child: AddNewTypeDialog(
              add: add,
              controller: controller,
              formKey: formKey,
            ),
          ));
}
