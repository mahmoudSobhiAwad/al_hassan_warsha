import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_adaptive_layout.dart';
import 'package:al_hassan_warsha/features/home/presentation/manager/bloc/home_basic_bloc.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/alert_to_check_db.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/basic_home.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/home_desktop_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: BlocConsumer<HomeBasicBloc, HomeBasicState>(
              builder: (context, state) {
            var bloc = context.read<HomeBasicBloc>();
            return CustomAdaptiveLayout(
              desktopLayout: (context) => HomeScreenDesktopLayOut(
                bloc: bloc,
              ),
              mobileLayout: (context) => const Text("Mobile Layout"),
              tabletLayout: (context) => const Text("Tablet Layout"),
            );
          }, listener: (context, state) {
            var bloc = context.read<HomeBasicBloc>();

            if (state is NavToPageState) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BasicHomeView(
                            bloc: bloc,
                          )));
            } else if (state is NotFoundDbState) {
              showDialog(
                  useSafeArea: false,
                  context: context,
                  builder: (context) => Dialog(child: CustomAlert(
                        onPressed_2: () {
                          bloc.add(CreateNewDBEvent());
                          Navigator.pop(context);
                        },
                      )));
            } else if (state is CreateDataBaseSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: AppColors.green,
                content: Text(
                  "تم إنشاء قاعدة البيانات بنجاح ",
                  style: AppFontStyles.extraBold20(context)
                      .copyWith(color: AppColors.white),
                ),
              ));
            } else if (state is CreateDataBaseFailedState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: AppColors.red,
                content: Text(
                  "${state.errMessage}",
                  style: AppFontStyles.extraBold20(context)
                      .copyWith(color: AppColors.white),
                ),
              ));
            }
          }),
        ),
      ),
    );
  }
}
