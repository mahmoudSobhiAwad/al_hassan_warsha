import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/app_bar_with_linking.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/customer_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/tablet_layout/add_order_body_tablet.dart';
import 'package:flutter/material.dart';

class AddOrderViewTablet extends StatelessWidget {
  const AddOrderViewTablet({super.key, required this.bloc, this.model});
  final ManagementBloc bloc;
  final CustomerModel? model;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppBarWithLinking(
          items: ["إدارة الورشة", "اضافة عمل جديد"],
          fontSize: 22,
        ),
        AddOrderBodyTabletLayOut(
          bloc: bloc,
          model: model,
        ),
      ],
    );
  }
}

