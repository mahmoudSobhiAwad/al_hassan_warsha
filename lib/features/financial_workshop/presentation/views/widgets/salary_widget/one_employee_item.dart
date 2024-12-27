import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_drop_down.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/salary_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/action_types_in_dialog.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/alert_to_check_db.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        Expanded(
            flex: 4,
            child: CustomColumnWithTextInAddNewType(
              text: "اسم الموظف ",
              enableBorder: true,
              borderWidth: 2,
              textLabel: '',
              textInnerStyle: isTabletLayOut?AppFontStyles.bold10(context): AppFontStyles.bold16(context),
              readOnly: !workerModel.enableEdit,
              controller: TextEditingController(text: workerModel.workerName),
              onChanged: (value) {
                workerModel.workerName = value ?? "";
              },
              maxLine: 1,
            )),
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
            flex: 3,
            child: CustomColumnWithTextInAddNewType(
              text: "الراتب",
              enableBorder: true,
              readOnly: !workerModel.enableEdit,
              controller: TextEditingController(text: workerModel.salaryAmount),
              onChanged: (value) {
                workerModel.salaryAmount = value ?? "";
              },
              borderWidth: 2,
              textLabel: '',
              textInnerStyle: isTabletLayOut?AppFontStyles.bold12(context): AppFontStyles.bold16(context),
              textInputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(
                      r'[0-9\u0660-\u0669\u06F0-\u06F9]'), // Allow Arabic and English numerals only
                )
              ],
              maxLine: 1,
            )),
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
            flex: 3,
            child: CustomColumnWithTextInAddNewType(
              text: "رقم الهاتف ",
              textInnerStyle: isTabletLayOut?AppFontStyles.bold10(context): AppFontStyles.bold16(context),
              readOnly: !workerModel.enableEdit,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(
                      r'[0-9\u0660-\u0669\u06F0-\u06F9]'), // Allow Arabic and English numerals only
                )
              ],
              enableBorder: true,
              borderWidth: 2,
              textInputType: TextInputType.phone,
              controller: TextEditingController(text: workerModel.workerPhone),
              onChanged: (value) {
                workerModel.workerPhone = value ?? "";
              },
              textLabel: '',
              maxLine: 1,
            )),
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 3,
          child: CustomContainerWithDropDownList(
            primaryStyle: isTabletLayOut?AppFontStyles.bold10(context): AppFontStyles.bold16(context),
            enableDropDwon: workerModel.enableEdit,
            primaryText: switch (workerModel.salaryType) {
              SalaryType.daily => "يومي",
              SalaryType.weekly => "أسبوعي",
              SalaryType.monthly => 'شهري',
            },
            headerText: "نظام القبض",
            onSelected: (model) {
              changeSalaryType(model.valueEnSearh);
            },
            headerStyle: isTabletLayOut
                ? AppFontStyles.bold10(context)
                : AppFontStyles.extraBoldNew14(context),
            dropDownList: [
              SearchModel(valueArSearh: "يومي", valueEnSearh: SalaryType.daily),
              SearchModel(
                  valueArSearh: "أسبوعي", valueEnSearh: SalaryType.weekly),
              SearchModel(
                  valueArSearh: "شهري", valueEnSearh: SalaryType.monthly),
            ],
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
