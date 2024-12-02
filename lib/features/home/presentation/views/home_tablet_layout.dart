import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/home/data/home_data.dart';
import 'package:al_hassan_warsha/features/home/presentation/manager/bloc/home_basic_bloc.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/clipped_container.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/home_box_item.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/home_box_list.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/logo_widget.dart';
import 'package:flutter/material.dart';

class HomeScreenTabletLayout extends StatelessWidget {
  const HomeScreenTabletLayout({super.key, required this.bloc});
  final HomeBasicBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ClippedContainer(),
        SingleChildScrollView(
          child: Column(
            children: [
              FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "الحسن ",
                    style: AppFontStyles.extraBold90(context),
                  )),
              const SizedBox(
                height: 24,
              ),
              FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "اختيارك الأمثل لجميع أعمال الالوميتال",
                    style: AppFontStyles.extraBold60(context),
                  )),
              const SizedBox(
                height: 36,
              ),
              bloc.isLoading
                  ? const CircularProgressIndicator()
                  : HomeItemsList(bloc: bloc)
            ],
          ),
        ),
        const LogoWidget(),
      ],
    );
  }
}
