import 'package:al_hassan_warsha/core/utils/functions/extentions.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_mobile_app_bar.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/bloc/gallery_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/add_new_type_dialog.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/mobile_layout/gallery_mobile_body.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/side_bar_gallery.dart';
import 'package:flutter/material.dart';

class MobileGalleryView extends StatelessWidget {
  const MobileGalleryView({super.key, required this.bloc});
  final GalleryBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            CustomMobileAppBar(
              onCreate: () {
                showDialogToAddNewKitchenType(
                  context,
                  formKey: bloc.formKey,
                  controller: bloc.controller,
                  add: () {
                    if (bloc.formKey.currentState!.validate() &&
                        bloc.controller.text.trim().isNotEmpty) {
                      bloc.add(AddNewKitchenTypeEvent());
                    }
                  },
                );
              },
              openDrawer: () {
                bloc.add(ChangeSideBarActivationEvent());
              },
              title: "المعرض ",
            ),
            GalleryMobileBody(
              bloc: bloc,
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
        bloc.isSideBarActive
            ? SideBarGallery(
                constraints: BoxConstraints(
                  maxWidth: context.screenWidth * 0.7,
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

