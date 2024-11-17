import 'package:al_hassan_warsha/core/utils/functions/service_locator.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_adaptive_layout.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_snack_bar.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/data/pages_gallery_enum.dart';
import 'package:al_hassan_warsha/features/gallery/data/repos/add_edit_repos/add_edit_repo_impl.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/view_edit_add_bloc/bloc/view_edit_add_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/custom_kitchen_gallery_parent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewKitchenInGalleryView extends StatelessWidget {
  const ViewKitchenInGalleryView({
    super.key,
    required this.pagesGalleryEnum,
    this.titleOfAppBar,
    this.typeId,
    this.kitchenModel,
  });
  final PagesGalleryEnum pagesGalleryEnum;
  final String? titleOfAppBar;
  final String? typeId;
  final KitchenModel?kitchenModel;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) => ViewEditAddBloc(pagesGalleryEnum: pagesGalleryEnum,addEditKitchenRepoImpl: getIt.get<AddEditKitchenRepoImpl>()),
        child: BlocConsumer<ViewEditAddBloc, ViewEditAddState>(
            builder: (context, state) {
              var bloc=context.read<ViewEditAddBloc>();
              return SafeArea(
                child: Scaffold(
                  backgroundColor: AppColors.white,
                  body: CustomAdaptiveLayout(
                    desktopLayout: (context) => KitchenGalleryCustomView(
                      bloc: bloc,
                      typeId: typeId,
                      kitchenModel: kitchenModel,
                      titleOfAppBar: titleOfAppBar,
                    ),
                    mobileLayout: (context) => const Text("Mobile Layout"),
                    tabletLayout: (context) => const Text("Tablet Layout"),
                  ),
                ),
              );
            },
            listener: (context,state){
              if(state is SuccessAddNewKitchenState){
                showCustomSnackBar(context, "تمت اضافة مطبخ جديد");
              }
              else if(state is FailureAddNewKitchenState){
                showCustomSnackBar(context, "${state.errMessage}",backgroundColor: AppColors.red);
              }
              

            }),
      ),
    );
  }
}
