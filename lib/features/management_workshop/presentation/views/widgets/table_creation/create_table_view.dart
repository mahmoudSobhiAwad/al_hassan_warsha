import 'dart:developer';

import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_adaptive_layout.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_snack_bar.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/cubit/table_cubit.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/table_creation/create_table_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TableManager extends StatelessWidget {
  const TableManager({super.key});
  @override
  Widget build(BuildContext context) {
    log("rebuild view");
    return BlocProvider(
      create: (context) => TableCubit(),
      child: BlocConsumer<TableCubit, TableState>(
        listener: (context, state) {
          if (state is FailureCreateOrEditTableState) {
            showCustomSnackBar(context, state.errMessage ?? "",
                backgroundColor: AppColors.red);
          }
        },
        builder: (context, state) {
          var tableCubit = context.read<TableCubit>();
          return Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
              child: Scaffold(
                  backgroundColor: AppColors.white,
                  body: CustomAdaptiveLayout(
                    desktopLayout: (context) {
                      return CreateTableBody(tableCubit: tableCubit);
                    },
                    mobileLayout: (context) =>
                        const Text("هذه الخدمة غير متوفرة لدي هذا الحجم"),
                    tabletLayout: (context) {
                      return CreateTableBody(tableCubit: tableCubit);
                    },
                  )),
            ),
          );
        },
      ),
    );
  }
}
