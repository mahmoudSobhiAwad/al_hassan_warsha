import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/worker_model.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/manager/bloc/finanical_bloc.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/mobile_layout/edit_add_worker_alert.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/mobile_layout/edit_remove_pop_menu.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/mobile_layout/worker_item.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_box_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListOfWorkerInMobileLayOut extends StatelessWidget {
  const ListOfWorkerInMobileLayOut({
    super.key,
    required this.bloc,
    required this.workersList,
    required this.nameController,
    required this.salaryController,
    required this.phoneController,
    required this.salaryType,
  });

  final FinanicalBloc bloc;
  final List<WorkerModel> workersList;
  final TextEditingController nameController;
  final TextEditingController salaryController;
  final TextEditingController phoneController;
  final SalaryType salaryType;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.builder(
            itemCount: workersList.length,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 20),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    boxShadow: [customLowBoxShadow()],
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: AppColors.white),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Checkbox(
                            value: workersList[index].isSelected,
                            activeColor: AppColors.green,
                            onChanged: (value) {
                              bloc.add(SelectWorkerEvent(
                                  index: index, isSelectAll: false));
                            }),
                        EditOrRemovePopMenu(
                          openForEdit: () async {
                            bloc.add(PrepareBeforeEditWorkerInMobileLayout(
                                index: index));
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return BlocBuilder<FinanicalBloc,
                                      FinanicalState>(
                                    bloc: bloc,
                                    builder: (context, state) {
                                      return EditOrAddWorkerAlert(
                                        isEdit: true,
                                        nameController: nameController,
                                        salaryController: salaryController,
                                        phoneController: phoneController,
                                        salaryType: salaryType,
                                        changeSalaryType: (type) {
                                          bloc.add(ChangeSalaryTypeEvent(
                                              type: type,
                                              index: index,
                                              isMobile: true));
                                        },
                                        onTap: () {
                                          bloc.add(
                                              PrepareToSaveChangesFromMobile(
                                                  index: index, isEdit: true));
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  );
                                });
                          },
                          onDeleteItem: () {
                            bloc.add(DeleteWorkerEvent(index: index));
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Flexible(
                      child: WorkersItemInMobileLayout(
                          workerModel: workersList[index]),
                    ),
                  ],
                ),
              );
            }));
  }
}
