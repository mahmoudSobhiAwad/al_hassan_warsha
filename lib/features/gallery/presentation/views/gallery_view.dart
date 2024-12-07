import 'package:al_hassan_warsha/core/utils/functions/service_locator.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_adaptive_layout.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_snack_bar.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/bloc/gallery_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/gallery_view_desktop.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/mobile_layout/gallery_view_mobile.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/tablet_layout/gallery_tablet_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryView extends StatelessWidget {
  const GalleryView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GalleryBloc(galleryRepoImp: getIt.get())
        ..add(GetAllGalleryDataEvent())
        ..add(DefineTimerFunctionEvent()),
      child:
          BlocConsumer<GalleryBloc, GalleryState>(listener: (context, state) {
        if (state is SuccessAddedNewKitchenType) {
          Navigator.pop(context);
          showCustomSnackBar(
            context,
            "تم اضافة نوع جديد",
          );
        } else if (state is FailureCreateOrGetData) {
          showCustomSnackBar(context, " ${state.errMessage} ",
              backgroundColor: AppColors.red);
        } else if (state is FailureAddedNewKitchenType) {
          Navigator.pop(context);
          showCustomSnackBar(context, " ${state.errMessage} ",
              backgroundColor: AppColors.red);
        } else if (state is FailureFetchMoreKitchenState) {
          showCustomSnackBar(context, " ${state.errMessage} ",
              backgroundColor: AppColors.red);
        }
      }, builder: (context, state) {
        var galleryBloc = context.read<GalleryBloc>();

        return Expanded(
          child: CustomAdaptiveLayout(
            desktopLayout: (
              context,
            ) =>
                GalleryViewForDesktopLayOut(
              galleryBloc: galleryBloc,
            ),
            mobileLayout: (context) => MobileGalleryView(
              bloc: galleryBloc,
            ),
            tabletLayout: (
              context,
            ) =>
                GalleryTabletView(
              bloc: galleryBloc,
            ),
          ),
        );
      }),
    );
  }
}
