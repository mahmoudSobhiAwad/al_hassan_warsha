import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_app_bar.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/add_order_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEditViewOrder extends StatelessWidget {
  const AddEditViewOrder({super.key,required this.bloc});
  final ManagementBloc bloc;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context,state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.white,
              body: Column(
                children: [
                  CustomAppBar(changeIndex: (index) {}, currIndex: 1),
                  const SizedBox(
                    height: 12,
                  ),
                  AddOrderBody(bloc: bloc,),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}





