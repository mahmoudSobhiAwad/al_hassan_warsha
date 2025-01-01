import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/manager/bloc/finanical_bloc.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/mobile_layout/edit_add_worker_alert.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/mobile_layout/workers_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalaryForWorkersMobileLayOut extends StatelessWidget {
  const SalaryForWorkersMobileLayOut({
    super.key,
    required this.bloc,
  });
  final FinanicalBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  " المرتبات والموظفين",
                  style: AppFontStyles.extraBoldNew18(context),
                ),
                Row(
                  children: [
                    Text("تحديد الكل ",style: AppFontStyles.bold14(context),),
                    Checkbox(value: bloc.isAllSelected,
                    activeColor: AppColors.green,
                     onChanged: (value){
                      bloc.add(SelectWorkerEvent(index: 0, isSelectAll: true));
                    })
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ListOfWorkerInMobileLayOut(
              bloc: bloc,
              nameController: bloc.workerNameController,
              salaryController: bloc.workerSalaryController,
              phoneController: bloc.workerPhoneController,
              salaryType: bloc.salaryType,
              workersList: bloc.workersList,
            ),
            const SizedBox(
              height: 12,
            ),
            Center(
              child: CustomPushContainerButton(
                borderRadius: 10,
                color: AppColors.blueGray,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                pushButtomText: "دفع المرتبات المحددة",
                pushButtomTextFontSize: 16,
                enableIcon: false,
                onTap: () {
                  bloc.add(PayAllSalariesEvent());
                },
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: ElevatedButton(
            onPressed: () {
              bloc.add(PrepareBeforeAddWorkerInMobileLayout());
              showDialog(
                  context: context,
                  builder: (context) {
                    return BlocBuilder<FinanicalBloc, FinanicalState>(
                      bloc: bloc,
                      builder: (context, state) {
                        return EditOrAddWorkerAlert(
                            nameController: bloc.workerNameController,
                            salaryController: bloc.workerSalaryController,
                            phoneController: bloc.workerPhoneController,
                            salaryType: bloc.salaryType,
                            changeSalaryType: (value) {
                              bloc.add(ChangeSalaryTypeEvent(
                                  type: value, index: 0, isMobile: true));
                            },
                            onTap: () {
                              bloc.add(PrepareToSaveChangesFromMobile());
                              Navigator.pop(context);
                            });
                      },
                    );
                  });
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blueGray,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20)),
            child: const Icon(
              Icons.add,
              size: 30,
              color: AppColors.white,
            ),
          ),
        )
      ],
    );
  }
}
