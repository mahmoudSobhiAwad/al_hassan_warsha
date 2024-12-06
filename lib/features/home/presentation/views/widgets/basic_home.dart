import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_adaptive_layout.dart';
import 'package:al_hassan_warsha/features/home/presentation/manager/bloc/home_basic_bloc.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/basic_home_desktop.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/bottom_nav_bar_phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasicHomeView extends StatelessWidget {
  const BasicHomeView({
    super.key,
    required this.bloc,
  });
  final HomeBasicBloc bloc;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
              child: Scaffold(
                  backgroundColor: AppColors.white,
                  bottomNavigationBar: CustomAdaptiveLayout(
                    desktopLayout: (context,[constraint]) => const SizedBox(),
                    mobileLayout: (context) => CustomBottomNavBarForPhone(
                      changePage: (index) {
                        bloc.add(ChangeCurrentPageEvent(currIndex: index));
                      },
                      currIndex: bloc.currIndex,
                    ),
                    tabletLayout: (context,[constraints]) => const SizedBox(),
                  ),
                  body: BasicHomeWithDiffrentLayOut(
                    currIndex: bloc.currIndex,
                    changeIndex: (index) {
                      bloc.add(ChangeCurrentPageEvent(currIndex: index));
                    },
                  )),
            ),
          );
        });
  }
}
