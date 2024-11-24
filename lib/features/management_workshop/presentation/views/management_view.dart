import 'package:al_hassan_warsha/core/utils/functions/service_locator.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_snack_bar.dart';
import 'package:al_hassan_warsha/core/utils/widgets/empty_data_screen.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/repos/management_repo_impl.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/add_edit_view.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/management_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagementView extends StatelessWidget {
  const ManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ManagementBloc(managementRepoImpl: getIt.get<ManagementRepoImpl>())
            ..add(GetAllOrdersEvent()),
      child: BlocConsumer<ManagementBloc, ManagementState>(
          builder: (context, state) {
        var bloc = context.read<ManagementBloc>();
        return bloc.isLoadingAllOrders
            ? const CircularProgressIndicator()
            : (bloc.ordersList.isNotEmpty)
                ? ManagmentBody(bloc: bloc)
                : EmptyDataScreen(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddEditViewOrder(
                                    bloc: bloc,
                                  )));
                    },
                    emptyPushButtonText: "اضافة طلب جديد",
                    emptyText: "لا يوجد اي طلبات حاليا لدي الورشة",
                  );
      }, listener: (context, state) {
        if (state is FailureGetAllOrdersState) {
          showCustomSnackBar(
            context,
            state.errMessage ?? "",
            backgroundColor: AppColors.red,
          );
        } 
      }),
    );
  }
}
