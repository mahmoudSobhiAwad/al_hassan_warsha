import 'package:al_hassan_warsha/core/utils/functions/service_locator.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_adaptive_layout.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_snack_bar.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/repos/management_repo_impl.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/edit_order_view.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/management_body.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/mobile_layout/managment_mobile_layout_view.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/tablet_layout/managemnt_tablet_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagementView extends StatelessWidget {
  const ManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ManagementBloc(managementRepoImpl: getIt.get<ManagementRepoImpl>())
            ..add(GetAllOrdersEvent())
            ..add(GetAllKitchenTypesEvent()),
      child: BlocConsumer<ManagementBloc, ManagementState>(
          builder: (context, state) {
        var bloc = context.read<ManagementBloc>();
        return Expanded(
          child: CustomAdaptiveLayout(
              desktopLayout: (context) => ManagmentBody(bloc: bloc,),
              mobileLayout: (context) => const ManagmentMobileView(),
              tabletLayout: (context) => ManagemntTabletView(bloc: bloc,),
              ),
        );
      }, listener: (context, state) {
        var bloc = context.read<ManagementBloc>();
        if (state is FailureGetAllOrdersState) {
          showCustomSnackBar(
            context,
            state.errMessage ?? "",
            backgroundColor: AppColors.red,
          );
        } else if (state is ChangeCurrentEditableModelState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      EditOrderView(bloc: bloc, orderModel: state.model)));
        }
      }),
    );
  }
}
