import 'package:al_hassan_warsha/core/utils/functions/extentions.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/bloc/gallery_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/side_bar_gallery.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/tablet_layout/app_bar_in_gallery.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/tablet_layout/tablet_gallery_body.dart';
import 'package:flutter/material.dart';

class GalleryTabletView extends StatelessWidget {
  const GalleryTabletView({
    super.key,
    required this.bloc,
  });
  final GalleryBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            TypeBarInTabletGallery(onTap: () {
              bloc.add(ChangeSideBarActivationEvent());
            }),
            const SizedBox(
              height: 15,
            ),
            TabletGalleryBody(bloc: bloc),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
        bloc.isSideBarActive
            ? SideBarGallery(
                constraints: BoxConstraints(
                  maxWidth: context.screenWidth * 0.4,
                ),
                openCloseSideBar: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        padding: const EdgeInsets.only(bottom: 24),
                        onPressed: () {
                          bloc.add(ChangeSideBarActivationEvent());
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          size: 30,
                        ))),
                currIndex: bloc.showingIndex,
                changeIndex: (index) {
                  if (index != bloc.showingIndex) {
                    bloc.add(ShowMoreKitcenTypeEvent(
                        currIndex: index,
                        isOpen: true,
                        typeId: bloc.onlyTypeModelList[index].typeId));
                  }
                },
                addType: () {
                  bloc.add(AddNewKitchenTypeEvent());
                },
                typesList: bloc.onlyTypeModelList,
                controller: bloc.controller,
                formKey: bloc.formKey,
              )
            : const SizedBox(),
      ],
    );
  }
}

