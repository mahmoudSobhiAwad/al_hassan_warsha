import 'dart:async';

import 'package:al_hassan_warsha/core/utils/functions/service_locator.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_adaptive_layout.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_snack_bar.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/data/pages_gallery_enum.dart';
import 'package:al_hassan_warsha/features/gallery/data/repos/add_edit_repos/add_edit_repo_impl.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/bloc/gallery_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/view_edit_add_bloc/bloc/view_edit_add_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/custom_kitchen_gallery_parent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewKitchenInGalleryView extends StatefulWidget {
  const ViewKitchenInGalleryView({
    super.key,
    required this.pagesGalleryEnum,
    this.titleOfAppBar,
    this.typeId,
    this.kitchenModel,
    required this.galleryBloc,
  });
  final PagesGalleryEnum pagesGalleryEnum;
  final String? titleOfAppBar;
  final String? typeId;
  final KitchenModel? kitchenModel;
  final GalleryBloc galleryBloc;

  @override
  State<ViewKitchenInGalleryView> createState() =>
      _ViewKitchenInGalleryViewState();
}

class _ViewKitchenInGalleryViewState extends State<ViewKitchenInGalleryView> {
  List<PickedMedia> pickedMediaList = [];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) => ViewEditAddBloc(
            pagesGalleryEnum: widget.pagesGalleryEnum,
            addEditKitchenRepoImpl: getIt.get<AddEditKitchenRepoImpl>()),
        child: BlocConsumer<ViewEditAddBloc, ViewEditAddState>(
            builder: (context, state) {
          var bloc = context.read<ViewEditAddBloc>();
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.white,
              body: CustomAdaptiveLayout(
                desktopLayout: (context) => KitchenGalleryCustomView(
                  bloc: bloc,
                  typeId: widget.typeId,
                  kitchenModel: widget.kitchenModel,
                  titleOfAppBar: widget.titleOfAppBar,
                  kitchenMediaList: pickedMediaList,
                ),
                mobileLayout: (context) => const Text("Mobile Layout"),
                tabletLayout: (context) => const Text("Tablet Layout"),
              ),
            ),
          );
        }, listener: (context, state) {
          var bloc = context.read<ViewEditAddBloc>();
          if (state is SuccessAddNewKitchenState) {
            pickedMediaList = [];
            showCustomSnackBar(context, "تمت اضافة مطبخ جديد");
            widget.galleryBloc.add(
                FetchKitchenTypeAfterChangeEvent(typeId: state.model.typeId));
                
          } else if (state is FailureAddNewKitchenState) {
            showCustomSnackBar(context, "${state.errMessage}",
                backgroundColor: AppColors.red);
          } else if (state is SuccessDeleteNewKitchenState) {
            showCustomSnackBar(context, "تمت حذف المطبخ ");
            widget.galleryBloc.add(FetchKitchenTypeAfterChangeEvent(
              typeId: state.typeId,
            ));
            Navigator.pop(context);
            Timer(const Duration(milliseconds: 500), () {
              Navigator.pop(context);
            });
          } else if (state is SuccessEditKitchenState) {
            showCustomSnackBar(context, "تمت تعديل المطبخ بنجاح ");
            
            widget.galleryBloc
                .add(FetchKitchenTypeAfterChangeEvent(typeId: state.typeId));
            bloc.add(OpenKitchenForEditEvent(enableEdit: false));
          } else if (state is FailureAddNewKitchenState) {
            showCustomSnackBar(context, "${state.errMessage}",
                backgroundColor: AppColors.red);
          } else if (state is SuccessAddMediaState) {
            pickedMediaList = state.list;
          } else if (state is SuccessAddMoreMediaState) {
            pickedMediaList.addAll(state.list);
          } else if (state is RemoveOneMediaState) {
            pickedMediaList.removeAt(state.index);
          } else if (state is ToggleBetweenEditAndViewState) {
            if (state.enableOpen) {
              pickedMediaList = widget.kitchenModel!.getPickedMedia();
            }
          }
        }),
      ),
    );
  }
}
