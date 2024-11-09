import 'package:al_hassan_warsha/core/utils/widgets/custom_app_bar.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/financial_view.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/gallery_view.dart';
import 'package:al_hassan_warsha/features/home/presentation/manager/bloc/home_basic_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/management_view.dart';
import 'package:flutter/material.dart';

class BasicHomeDesktopLayOut extends StatelessWidget {
  const BasicHomeDesktopLayOut({super.key, required this.index, required this.bloc});
  final HomeBasicBloc bloc;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          currIndex: index,
          changeIndex: (pageIndex) {
            bloc.add(ChangeCurrentPageEvent(currIndex: pageIndex));
          },
        ),
        const [
          GalleryView(),
          ManagementView(),
          FinancialView(),
        ][index],
      ],
    );
  }
}
