import 'package:al_hassan_warsha/core/utils/functions/extentions.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/cubit/table_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<dynamic> changeFontSize(BuildContext context,
    {required int colIndex, required int rowIndex, required TableCubit cubit}) {
  return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => BlocBuilder<TableCubit, TableState>(
            bloc: cubit,
            builder: (context, state) {
              return Dialog(
                  child: Container(
                padding: const EdgeInsets.all(5),
                constraints: BoxConstraints(
                    maxWidth: 300, maxHeight: context.screenHeight * 0.3),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8)),
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
                    Text(
                      "تغيير حجم الخط ",
                      style: AppFontStyles.bold16(context),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(width: 2, color: AppColors.lightGray1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                               cubit.changeFontSize(fontState: false, colIndex: colIndex, rowIndex: rowIndex);
                              },
                              icon: const Icon(
                                CupertinoIcons.minus_circle_fill,
                                color: Colors.black,
                                size: 30,
                              )),
                          Text(
                            "${cubit.cellList[rowIndex][colIndex].getFontSize}",
                            style: AppFontStyles.bold18(context),
                          ),
                          IconButton(
                              onPressed: () {
                               cubit.changeFontSize(fontState: true, colIndex: colIndex, rowIndex: rowIndex);
                              },
                              icon: const Icon(
                                Icons.add_circle_outlined,
                                size: 30,
                              )),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ));
            },
          ));
}
