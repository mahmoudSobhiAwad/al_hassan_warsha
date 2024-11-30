import 'package:al_hassan_warsha/core/utils/functions/service_locator.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_snack_bar.dart';
import 'package:al_hassan_warsha/core/utils/widgets/empty_data_screen.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/bloc/gallery_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/all_kitchen_items_body.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_dialog_add_new_type.dart';
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
        ..add(GetAllGalleryDataEvent()),
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
                        typeId: galleryBloc.onlyTypeModelList[index].typeId));
                  }
                },
                addType: () {
                  galleryBloc.add(AddNewKitchenTypeEvent());
                },
                typesList: galleryBloc.onlyTypeModelList,
                controller: galleryBloc.controller,
                formKey: galleryBloc.formKey,
              )),
              galleryBloc.enableMoreWidget
                  ? Expanded(
                      flex: 4,
                      child: ShowingAllKitchenItemsGrid(
                        currentTypeModel: galleryBloc.currentShowMoreModel,
                        bloc: galleryBloc,
                      ),
                    )
                  : galleryBloc.basickitchenTypesList.isNotEmpty
                      ? Expanded(
                          flex: 4,
                          child: GalleryBody(
                            kitchenList: galleryBloc.basickitchenTypesList,
                            bloc: galleryBloc,
                          ))
                      : EmptyDataScreen(
                        flex: 4,
                          emptyText: "ليس لديك اي انواع من المطابخ اضف واحدا ",
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => Form(
                                      key: galleryBloc.formKey,
                                      child: AddNewTypeDialog(
                                        add: () {
                                          if (galleryBloc.formKey.currentState!
                                                  .validate() &&
                                              galleryBloc.controller.text
                                                  .trim()
                                                  .isNotEmpty) {
                                            galleryBloc
                                                .add(AddNewKitchenTypeEvent());
                                          }
                                        },
                                        controller: galleryBloc.controller,
                                        formKey: galleryBloc.formKey,
                                      ),
                                    ));
                          },
                        ),
            ],
          ),
        );
      }),
    );
  }
}
