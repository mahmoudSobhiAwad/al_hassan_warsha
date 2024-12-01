import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_adaptive_layout.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_snack_bar.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/action_types_in_dialog.dart';
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
            if (state is CreateDataBaseSuccessState) {
              showCustomSnackBar(context, "تم انشاء قاعدة البيانات بنجاح ");
            } else if (state is NavToPageState) {
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
            } else if (state is ShowConfirmationDialog) {
              showDialog(
                  useSafeArea: false,
                  context: context,
                  builder: (context) => BlocBuilder(
                        bloc: bloc,
                        builder: (context, state) {
                          return Dialog(
                              child: CustomAlert(
                            title: "انشاء قاعدة بيانات جديدة",
                            iconData: Icons.create,
                            pickPathesWidget: PickPathForDb(
                              pickTempPath: () {
                                bloc.add(CreatePathForMeidaAndTempDataEvent());
                              },
                              tempPath: bloc.tempPath,
                            ),
                            actionButtonsInstead: DialogAddNewTypeActionButton(
                              text_1: "تأكيد ",
                              text_2: "الغاء ",
                              onPressed_1: () {
                                bloc.add(ConfirmToCreateTheNewDb());
                                Navigator.pop(context);
                              },
                              onPressed_2: () {
                                Navigator.pop(context);
                              },
                            ),
                          ));
                        },
                      ));
            } else if (state is CreateDataBaseFailedState) {
              showCustomSnackBar(context, state.errMessage ?? "",
                  backgroundColor: AppColors.red);
            }
          }),
        ),
      ),
    );
  }
}
