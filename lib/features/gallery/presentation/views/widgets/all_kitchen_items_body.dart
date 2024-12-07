import 'package:al_hassan_warsha/core/utils/widgets/custom_pagination.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_type.dart';
import 'package:al_hassan_warsha/features/gallery/data/pages_gallery_enum.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/bloc/gallery_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/gride_view_list.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/app_bar_with_linking.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/view_type_kitchen_view.dart';
import 'package:flutter/material.dart';

class ShowingAllKitchenItemsGrid extends StatelessWidget {
  const ShowingAllKitchenItemsGrid({
    super.key,
    required this.bloc,
    required this.currentTypeModel,
    this.aspectRatio = 2,
    this.fontSize,
    this.crossAxisCount = 3,
    this.fontSizeInButtons,
    this.imageWidth = 0.4,
    this.iconSize,
    this.items,
    this.borderRadius,
  });

  final GalleryBloc bloc;
  final KitchenTypeModel currentTypeModel;
  final int crossAxisCount;
  final double imageWidth;
  final double aspectRatio;
  final double? fontSize;
  final double? fontSizeInButtons;
  final double? iconSize;
  final double? borderRadius;
  final List<String>? items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0,),
      child: Column(
        children: [
          AppBarWithLinking(
              iconSize: iconSize,
              fontSize: fontSize,
              enableColor: false,
              onBack: () {
                bloc.add(ShowMoreKitcenTypeEvent(
                  currIndex: -1,
                  isOpen: false,
                ));
              },
              items: items ??
                  [
                    "الرئيسية",
                    currentTypeModel.typeName,
                  ]),
          Align(
              alignment: Alignment.centerLeft,
              child: CustomPushContainerButton(
                pushButtomTextFontSize: fontSizeInButtons,
                pushButtomText: "اضافة مطبخ جديد",
                iconSize: iconSize,
                borderRadius: borderRadius,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewKitchenInGalleryView(
                                galleryBloc: bloc,
                                pagesGalleryEnum: PagesGalleryEnum.add,
                                typeId: currentTypeModel.typeId,
                                titleOfAppBar: currentTypeModel.typeName,
                              )));
                },
              )),
          const SizedBox(
            height: 16,
          ),
          Expanded(
              child: CustomGridKitchenTypes(
            crossAxisCount: crossAxisCount,
            aspectRatio: aspectRatio,
            imageWidth: imageWidth,
            bloc: bloc,
            kitchenList: currentTypeModel.kitchenList,
            typeId: currentTypeModel.typeId,
            appBarTitle: currentTypeModel.typeName,
          )),
          const SizedBox(
            height: 18,
          ),
          currentTypeModel.itemsCount > 10
              ? CustomPaginationWidget(
                  length: (currentTypeModel.itemsCount / 10).ceil(),
                  currentPage: bloc.currPageInShowMore,
                  onPageChanged: (int index) {
                    bloc.add(ChangePageIndexInShowMoreEvent(index: index));
                  },
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
