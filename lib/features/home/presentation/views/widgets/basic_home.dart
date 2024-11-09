import 'package:al_hassan_warsha/core/utils/widgets/custom_adaptive_layout.dart';
import 'package:al_hassan_warsha/features/home/presentation/manager/bloc/home_basic_bloc.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/basic_home_desktop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasicHomeView extends StatelessWidget {
  const BasicHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBasicBloc(),
      child:
          BlocBuilder<HomeBasicBloc, HomeBasicState>(builder: (context, state) {
        var bloc = context.read<HomeBasicBloc>();

        int index = 0;
        if (state is ToggleBetweenPagesState) {
          index = state.currIndex;
        }
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Scaffold(
              body: CustomAdaptiveLayout(
                  mobileLayout: (context) => const Text("mobile Layout"),
                  tabletLayout: (context) => const Text("tablet Layout"),
                  desktopLayout: (context) =>BasicHomeDesktopLayOut(index: index, bloc: bloc)),
            ),
          ),
        );
      }),
    );
  }
}
