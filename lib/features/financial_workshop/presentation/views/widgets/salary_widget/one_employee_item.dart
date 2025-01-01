import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/worker_model.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/salary_widget/phone_number_worker.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/salary_widget/salary_for_workers.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/salary_widget/salary_type_drop_down.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/salary_widget/worker_name.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/action_types_in_dialog.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/alert_to_check_db.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OneEmployeeItem extends StatelessWidget {
  const OneEmployeeItem(
      {super.key,
      required this.workerModel,
      required this.changeSalaryType,
      required this.selectItem,
      this.isTabletLayOut = false,
      required this.deleteItem});
  final WorkerModel workerModel;
  final void Function(SalaryType) changeSalaryType;
  final void Function() deleteItem;
  final void Function(bool) selectItem;
  final bool isTabletLayOut;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Checkbox(
            activeColor: AppColors.green,
            value: workerModel.isSelected,
            onChanged: (v) {
              selectItem(workerModel.isSelected);
            }),
        const SizedBox(
          width: 12,
        ),
        Expanded(flex: 4, child: WorkerName(workerModel: workerModel)),
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(flex: 3, child: SalaryForWorker(workerModel: workerModel)),
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
            flex: 3, child: PhoneNumberForWorker(workerModel: workerModel)),
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 3,
          child: SalaryTypeDropDown(
            isTabletLayOut: isTabletLayOut,
            enableDropDown: workerModel.enableEdit,
            changeSalaryType: changeSalaryType,
            salaryType: workerModel.salaryType,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        if (!isTabletLayOut)
          Tooltip(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.veryLightGray,
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: AppFontStyles.extraBoldNew16(context),
              message: workerModel.lastAddedSalary == null
                  ? "تاريخ اخر قبض غير محدد"
                  : DateFormat('d MMMM y, h:mm a', 'ar')
                      .format(workerModel.lastAddedSalary ?? DateTime.now()),
              child: const Icon(
                Icons.info,
                color: AppColors.orange,
                size: 33,
              )),
        const SizedBox(
          width: 10,
        ),
        IconButton(
            onPressed: () {
              if (workerModel.workerId == null) {
                deleteItem();
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: CustomAlert(
                          actionButtonsInstead: DialogAddNewTypeActionButton(
                            onPressed_1: () {
                              deleteItem();
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
              }
            },
            icon: const Icon(
              Icons.delete,
              color: AppColors.red,
              size: 33,
            ))
      ],
    );
  }
}
