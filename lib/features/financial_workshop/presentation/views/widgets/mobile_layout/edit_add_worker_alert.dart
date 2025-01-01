import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_widget_title.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/worker_model.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/salary_widget/phone_number_worker.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/salary_widget/salary_for_workers.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/salary_widget/salary_type_drop_down.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/salary_widget/worker_name.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_box_shadow.dart';
import 'package:flutter/material.dart';

class EditOrAddWorkerAlert extends StatelessWidget {
  const EditOrAddWorkerAlert({
    super.key,
    this.isEdit = false,
    required this.nameController,
    required this.salaryController,
    required this.phoneController,
    required this.salaryType,
    required this.changeSalaryType,
    required this.onTap,
  });
  final bool isEdit;
  final TextEditingController nameController;
  final TextEditingController salaryController;
  final TextEditingController phoneController;
  final SalaryType salaryType;
  final void Function(SalaryType type) changeSalaryType;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [customLowBoxShadow()],
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DialogTitleWithNav(title: isEdit ? "تعديل بيانات" : "اضافة جديد"),
            const SizedBox(
              height: 10,
            ),
            WorkerName(
              controller: nameController,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: SalaryForWorker(
                  controller: salaryController,
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: PhoneNumberForWorker(
                  phoneController: phoneController,
                )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Expanded(child: SizedBox()),
                Expanded(
                  flex: 3,
                  child: SalaryTypeDropDown(
                      isTabletLayOut: true,
                      salaryType: salaryType,
                      changeSalaryType: changeSalaryType,
                      enableDropDown: true),
                ),
                const Expanded(child: SizedBox()),
                Expanded(
                  flex: 4,
                  child: CustomPushContainerButton(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: AppColors.green,
                    borderRadius: 8,
                    pushButtomText: isEdit ? "تعديل" : "اضافة",
                    pushButtomTextFontSize: 16,
                    onTap: onTap,
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
