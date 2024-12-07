import 'package:al_hassan_warsha/core/utils/widgets/custom_adaptive_layout.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/data/pages_gallery_enum.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/view_edit_add_bloc/bloc/view_edit_add_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/add_kitchen_view.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/edit_kitchen_view.dart';
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
        CustomAdaptiveLayout(
          desktopLayout: (context) {
            return CustomAppBarInAddEditViewKitchen(
                titleOfAppBar: titleOfAppBar,
                pagesGalleryEnum: bloc.pagesGalleryEnum,
                onEditCase: () {
                  bloc.add(OpenKitchenForEditEvent(enableEdit: false));
                },
                kitchenModel: kitchenModel);
          },
          mobileLayout: (context) {
            return CustomAppBarInAddEditViewKitchen(
                fontSize: 16,
                titleOfAppBar: titleOfAppBar,
                items: [
                  titleOfAppBar ?? "مطبخ كلاسيك",
                  bloc.pagesGalleryEnum == PagesGalleryEnum.add
                      ? "إضافة مطبخ"
                      : kitchenModel?.kitchenName ?? "",
                ],
                pagesGalleryEnum: bloc.pagesGalleryEnum,
                onEditCase: () {
                  bloc.add(OpenKitchenForEditEvent(enableEdit: false));
                },
                kitchenModel: kitchenModel);
          },
          tabletLayout: (context) {
            return CustomAppBarInAddEditViewKitchen(
                fontSize: 24,
                titleOfAppBar: titleOfAppBar,
                pagesGalleryEnum: bloc.pagesGalleryEnum,
                onEditCase: () {
                  bloc.add(OpenKitchenForEditEvent(enableEdit: false));
                },
                kitchenModel: kitchenModel);
          },
        ),
        const SizedBox(
          height: 12,
        ),
        Expanded(
          child: Scrollbar(
            scrollbarOrientation: ScrollbarOrientation.right,
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(scrollbars: false),
              child: SingleChildScrollView(
                  primary: true,
                  child: switch (bloc.pagesGalleryEnum) {
                    PagesGalleryEnum.view => ViewKitchenDetailsBody(
                        bloc: bloc,
                        kitchenModel: kitchenModel,
                        changeEditState: (edit) {
                          bloc.add(
                              OpenKitchenForEditEvent(enableEdit: edit));
                        },
                        deleteKitchen: () {
                          bloc.add(DeleteKitchenEvent(
                              mediaPath:
                                  kitchenModel?.kitchenMediaList ?? [],
                              kitchenId: kitchenModel!.kitchenId,
                              typeId: kitchenModel!.typeId));
                        },
                      ),
                    PagesGalleryEnum.edit => EditKitchenView(
                        bloc: bloc,
                        model: kitchenModel!,
                        pickedList: kitchenMediaList,
                      ),
                    PagesGalleryEnum.add => AddKitchenView(
                        mediaList: kitchenMediaList,
                        typeId: typeId,
                        bloc: bloc,
                      ),
                  }),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomAppBarInAddEditViewKitchen extends StatelessWidget {
  const CustomAppBarInAddEditViewKitchen(
      {super.key,
      required this.titleOfAppBar,
      required this.kitchenModel,
      required this.onEditCase,
      required this.pagesGalleryEnum,
      this.items,
      this.fontSize});

  final String? titleOfAppBar;
  final KitchenModel? kitchenModel;
  final void Function() onEditCase;
  final PagesGalleryEnum pagesGalleryEnum;
  final List<String>? items;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return AppBarWithLinking(
      fontSize: fontSize,
      items: items ??
          [
            "الرئيسية",
            titleOfAppBar ?? "مطبخ كلاسيك",
            pagesGalleryEnum == PagesGalleryEnum.add
                ? "إضافة مطبخ"
                : kitchenModel?.kitchenName ?? "",
          ],
      onBack: () {
        switch (pagesGalleryEnum) {
          case PagesGalleryEnum.view:
            Navigator.pop(context);
            break;
          case PagesGalleryEnum.edit:
            onEditCase;
            break;
          case PagesGalleryEnum.add:
            Navigator.pop(context);
        }
      },
    );
  }
}
