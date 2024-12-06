import 'package:al_hassan_warsha/core/utils/widgets/empty_data_screen.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/bloc/gallery_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/add_new_type_dialog.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/all_kitchen_items_body.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/gallery_body.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/side_bar_gallery.dart';
import 'package:flutter/material.dart';

class GalleryViewForDesktopLayOut extends StatelessWidget {
  const GalleryViewForDesktopLayOut({
    super.key,
    required this.galleryBloc,
  });

  final GalleryBloc galleryBloc;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                      showDialogToAddNewKitchenType(
                        context,
                        formKey: galleryBloc.formKey,
                        controller: galleryBloc.controller,
                        add: () {
                          if (galleryBloc.formKey.currentState!.validate() &&
                              galleryBloc.controller.text.trim().isNotEmpty) {
                            galleryBloc.add(AddNewKitchenTypeEvent());
                          }
                        },
                      );
                    },
                  ),
      ],
    );
  }
}
