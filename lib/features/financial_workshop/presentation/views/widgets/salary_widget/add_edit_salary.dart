import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_ingradient.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/manager/bloc/finanical_bloc.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/salary_widget/one_employee_item.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/action_types_in_dialog.dart';
import 'package:flutter/material.dart';

class AddEditSalaryView extends StatelessWidget {
  const AddEditSalaryView(
      {super.key, required this.bloc, this.isTabletLayOut = false});
  final FinanicalBloc bloc;
  final bool isTabletLayOut;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        children: [
          bloc.workersList.isNotEmpty
              ? Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.lightGray1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "تحديد الكل ",
                          style: AppFontStyles.bold18(context),
                        ),
                        IconButton(
                          onPressed: () {
                            bloc.add(SelectWorkerEvent(
                                index: -1, isSelectAll: true));
                          },
                          icon: bloc.isAllSelected
                              ? const Icon(
                                  Icons.check_box,
                                  color: AppColors.green,
                                  size: 35,
                                )
                              : const Icon(
                                  Icons.check_box_outline_blank,
                                  size: 35,
                                ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
          const SizedBox(
            height: 14,
          ),
          bloc.isLoadingGetAllWorkers
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: bloc.workersList.isEmpty
                      ? Center(
                          child: Text(
                          "لا يوجد لديك موظفين حاليا ",
                          style: AppFontStyles.extraBoldNew38(context),
                        ))
                      : SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.4,
                          child: Scrollbar(
                            scrollbarOrientation: ScrollbarOrientation.right,
                            thickness: 12,
                            thumbVisibility: true,
                            trackVisibility: true,
                            child: ScrollConfiguration(
                              behavior: const ScrollBehavior()
                                  .copyWith(scrollbars: false),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: ListView.separated(
                                    primary: true,
                                    itemBuilder: (context, index) {
                                      return OneEmployeeItem(
                                        isTabletLayOut: isTabletLayOut,
                                        workerModel: bloc.workersList[index],
                                        changeSalaryType: (type) {
                                          bloc.add(ChangeSalaryTypeEvent(
                                              type: type, index: index));
                                        },
                                        deleteItem: () {
                                          bloc.add(
                                              DeleteWorkerEvent(index: index));
                                        },
                                        selectItem: (statue) {
                                          bloc.add(SelectWorkerEvent(
                                              index: index,
                                              isSelectAll: false));
                                        },
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        height: 16,
                                      );
                                    },
                                    itemCount: bloc.workersList.length),
                              ),
                            ),
                          ),
                        ),
                ),
          const SizedBox(
            height: 14,
          ),
          InkWell(
            onTap: () {
              bloc.add(AddNewWorkerEvent());
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: customLinearGradient(),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: const Center(
                    child: IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.add,
                          size: 33,
                          color: AppColors.white,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "إضافة موظف جديد",
                  style: AppFontStyles.extraBoldNew24(context).copyWith(
                    color: AppColors.blue,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          bloc.workersList.isEmpty
              ? const SizedBox()
              : switch (bloc.isEditEnabled) {
                  true => DialogAddNewTypeActionButton(
                      instead_1: bloc.isLoadingActionWorker
                          ? const CircularProgressIndicator(
                              color: AppColors.white,
                            )
                          : Text(
                              "حفظ",
                              style: AppFontStyles.extraBoldNew24(context)
                                  .copyWith(color: AppColors.white),
                            ),
                      text_2: "الغاء",
                      onPressed_1: () {
                        bloc.add(SaveChangesAddOrEditEvent());
                      },
                      onPressed_2: () {
                        bloc.add(EnableEditForWorkersEvent(isEdit: false));
                      },
                      color_2: AppColors.red,
                    ),
                  false => DialogAddNewTypeActionButton(
                      onPressed_1: () {
                        bloc.add(PayAllSalariesEvent());
                      },
                      onPressed_2: () {
                        bloc.add(EnableEditForWorkersEvent(isEdit: true));
                      },
                      instead_1: bloc.isLoadingActionWorker
                          ? const CircularProgressIndicator(
                              color: AppColors.white,
                            )
                          : Text(
                              "دفع المرتبات المحددة",
                              style: AppFontStyles.extraBoldNew24(context)
                                  .copyWith(
                                      color: AppColors.white,
                                      fontSize: isTabletLayOut ? 18 : null),
                            ),
                      text_2: "تعديل",
                      fontSize: isTabletLayOut ? 18 : null,
                      color_2: AppColors.blue,
                    ),
                }
        ],
      ),
    );
  }
}
