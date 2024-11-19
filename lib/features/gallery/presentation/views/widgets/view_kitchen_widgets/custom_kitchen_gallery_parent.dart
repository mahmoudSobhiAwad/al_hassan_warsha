import 'package:al_hassan_warsha/core/utils/widgets/custom_app_bar.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/data/pages_gallery_enum.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/view_edit_add_bloc/bloc/view_edit_add_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/add_kitchen_view.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/app_bar_with_linking.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/view_kitchen_details.dart';
import 'package:flutter/material.dart';

class KitchenGalleryCustomView extends StatelessWidget {
  const KitchenGalleryCustomView(
      {super.key,
      required this.bloc,
      this.titleOfAppBar,
      required this.typeId,
      this.kitchenMediaList = const [],
      required this.kitchenModel});

  final ViewEditAddBloc bloc;
  final String? titleOfAppBar;
  final String? typeId;
  final KitchenModel? kitchenModel;
  final List<PickedMedia> kitchenMediaList;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
            currIndex: 0,
            changeIndex: (pageIndex) {
              if (pageIndex != 0) {
                Navigator.pop(context);
                bloc.add(ChangeBarIndexEvent(currBarIndex: pageIndex));
              }
            }),
        const SizedBox(
          height: 24,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarWithLinking(
                  items: [
                    "الرئيسية",
                    titleOfAppBar ?? "مطبخ كلاسيك",
                    bloc.pagesGalleryEnum == PagesGalleryEnum.add
                        ? "إضافة مطبخ"
                        : kitchenModel?.kitchenName ?? "",
                  ],
                  onBack: () {
                    switch (bloc.pagesGalleryEnum) {
                      case PagesGalleryEnum.view:
                        Navigator.pop(context);
                        break;
                      case PagesGalleryEnum.edit:
                        bloc.add(OpenKitchenForEditEvent(enableEdit: false));
                        break;
                      case PagesGalleryEnum.add:
                        Navigator.pop(context);
                    }
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                switch (bloc.pagesGalleryEnum) {
                  PagesGalleryEnum.view => ViewKitchenDetailsBody(
                      kitchenModel: kitchenModel,
                      changeEditState: (edit) {
                        bloc.add(OpenKitchenForEditEvent(enableEdit: edit));
                      },
                      deleteKitchen: () {
                        bloc.add(DeleteKitchenEvent(
                            kitchenId: kitchenModel!.kitchenId,
                            typeId: kitchenModel!.typeId));
                      },
                    ),
                  PagesGalleryEnum.edit => AddKitchenView(
                      typeId: typeId,
                      bloc: bloc,
                      enableEdit: true,
                      mediaList: kitchenMediaList,
                      kitchenModel: kitchenModel,
                    ),
                  PagesGalleryEnum.add => AddKitchenView(
                      mediaList: kitchenMediaList,
                      typeId: typeId,
                      bloc: bloc,
                    ),
                },
              ],
            ),
          ),
        ),
      ],
    );
  }
}
