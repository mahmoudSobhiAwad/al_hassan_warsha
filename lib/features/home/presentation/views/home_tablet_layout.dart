import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/home/presentation/manager/bloc/home_basic_bloc.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/clipped_container.dart';
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
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "الحسن ",
                  style: AppFontStyles.extraBold55(context),
                )),
            const SizedBox(
              height: 24,
            ),
            FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "اختيارك الأمثل لجميع أعمال الالوميتال",
                  style: AppFontStyles.extraBold40(context),
                )),
          
            bloc.isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: Column(
                      children: [
                        const Expanded(flex: 3,child: SizedBox()),
                        Expanded(
                            flex: 3,
                            child: HomeItemsList(
                              bloc: bloc,
                              
                              textStyle: AppFontStyles.extraBold35(context),
                            )),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}
