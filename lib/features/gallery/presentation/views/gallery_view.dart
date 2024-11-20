import 'package:al_hassan_warsha/core/utils/functions/service_locator.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_snack_bar.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/bloc/gallery_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/all_kitchen_items_body.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/gallery_body.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/side_bar_gallery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryView extends StatelessWidget {
  const GalleryView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GalleryBloc(galleryRepoImp: getIt.get())
        ..add(CheckExistOfGalleryDataEvent()),
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
        return galleryBloc.isLoading
            ? const CircularProgressIndicator()
            : Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: SideBarGallery(
                            currIndex: galleryBloc.showingIndex,
                            changeIndex: (index) {
                              if (index != galleryBloc.showingIndex) {
                                galleryBloc.add(ShowMoreKitcenTypeEvent(
                                    currIndex: index,
                                    isOpen: true,
                                    typeId: galleryBloc
                                        .onlyTypeModelList[index].typeId));
                              }
                            },
                            addType: (value) {
                              galleryBloc
                                  .add(AddNewKitchenTypeEvent(typeName: value));
                            },
                            typesList: galleryBloc.onlyTypeModelList)),
                    galleryBloc.enableMoreWidget
                        ? Expanded(
                            flex: 4,
                            child: ShowingAllKitchenItemsGrid(
                              currentTypeModel:
                                  galleryBloc.currentShowMoreModel,
                              bloc: galleryBloc,
                            ),
                          )
                        : Expanded(
                            flex: 4,
                            child: GalleryBody(
                              kitchenList: galleryBloc.basickitchenTypesList,
                              bloc: galleryBloc,
                            ),
                          ),
                  ],
                ),
              );
      }),
    );
  }
}
