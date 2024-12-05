import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/home/presentation/manager/bloc/home_basic_bloc.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/clipped_container.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/home_box_list.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/logo_widget.dart';
import 'package:flutter/material.dart';

class HomeScreenDesktopLayOut extends StatelessWidget {
  const HomeScreenDesktopLayOut({super.key, required this.bloc});
  final HomeBasicBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ClippedContainer(),
        Column(
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
            bloc.isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                  child: Column(
                      children: [
                        const Expanded(child: SizedBox()),
                        Expanded(
                          flex: 5,
                          child: HomeItemsList(
                            bloc: bloc,
                          ),
                        ),
                        const Expanded(
                            child: SizedBox(
                          height: 25,
                        )),
                      ],
                    ),
                ),
          ],
        ),
        const LogoWidget(),
      ],
    );
  }
}
