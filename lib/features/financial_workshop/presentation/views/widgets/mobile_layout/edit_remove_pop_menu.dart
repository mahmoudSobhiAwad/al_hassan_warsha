import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/action_types_in_dialog.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/alert_to_check_db.dart';
import 'package:flutter/material.dart';

class EditOrRemovePopMenu extends StatelessWidget {
  const EditOrRemovePopMenu({
    super.key,
    required this.openForEdit,
    required this.onDeleteItem,
  });

  final void Function() onDeleteItem;
  final void Function() openForEdit;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: PopupMenuButton(
        color: AppColors.veryLightGray,
        icon: const Icon(Icons.more_vert_rounded),
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
                onTap: openForEdit,
                child: Row(
                  children: [
                    Text(
                      "تعديل",
                      style: AppFontStyles.bold12(context),
                    ),
                    const Icon(
                      Icons.edit,
                    )
                  ],
                )),
            PopupMenuItem(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: CustomAlert(
                            titleSize: 18,
                            actionButtonsInstead: DialogAddNewTypeActionButton(
                              fontSize: 18,
                              onPressed_1: () {
                                onDeleteItem();
                                Navigator.pop(context);
                              },
                              onPressed_2: () {
                                Navigator.pop(context);
                              },
                              text_1: "تاكيد",
                              text_2: "الغاء",
                            ),
                            enableIcon: false,
                            title: "هل تريد حذف هذا الموظف نهائيا ",
                          ),
                        );
                      });
                },
                child: Row(
                  children: [
                    Text(
                      "حذف",
                      style: AppFontStyles.bold12(context),
                    ),
                    const Icon(
                      Icons.delete,
                      color: AppColors.red,
                    )
                  ],
                )),
          ];
        },
      ),
    );
  }
}

