import 'package:al_hassan_warsha/core/utils/functions/extentions.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/table_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/cubit/table_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<dynamic> addNewRowOrColumn(
  BuildContext context,
  TableCubit cubit,
) {
  return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) {
        return BlocBuilder<TableCubit, TableState>(
          bloc: cubit,
          builder: (context, state) {
            return Dialog(
                child: Container(
              padding: const EdgeInsets.all(5),
              constraints: BoxConstraints(
                  maxWidth: 200, maxHeight: context.screenHeight * 0.4),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: AppColors.red,
                          )),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ...List.generate(insertOptionList.length, (index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            [
                              "انشاء صف للاسفل",
                              "انشاء صف للاعلي",
                              "انشاء عمود لليمين",
                              "انشاء عمود لليسار",
                            ][index],
                            style: AppFontStyles.bold16(context),
                          ),
                          Checkbox(
                              activeColor: AppColors.green,
                              value: insertOptionList[index].getIsActive,
                              onChanged: (value) {
                                cubit.changeInsertOption(index);
                              }),
                        ],
                      );
                    }),
                    const SizedBox(
                      height: 5,
                    ),
                    const CustomPushContainerButton(
                      pushButtomText: "اختيار",
                      pushButtomTextFontSize: 14,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      borderRadius: 8,
                      enableIcon: false,
                    )
                  ],
                ),
              ),
            ));
          },
        );
      });
}
