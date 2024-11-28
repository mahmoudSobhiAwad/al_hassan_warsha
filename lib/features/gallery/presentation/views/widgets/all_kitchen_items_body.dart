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
  });

  final GalleryBloc bloc;
  final KitchenTypeModel currentTypeModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Column(
        children: [
          AppBarWithLinking(
            enableColor: false,
              onBack: () {
                bloc.add(ShowMoreKitcenTypeEvent(
                  currIndex: -1,
                  isOpen: false,
                ));
              },
              items: [
                "الرئيسية",
                currentTypeModel.typeName,
              ]),
          Align(
              alignment: Alignment.centerLeft,
              child: CustomPushContainerButton(
                pushButtomText: "اضافة مطبخ جديد",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewKitchenInGalleryView(
                                galleryBloc: bloc,
                                pagesGalleryEnum: PagesGalleryEnum.add,
                                typeId: currentTypeModel.typeId,
                                titleOfAppBar:
                                    currentTypeModel.typeName,
                              )));
                },
              )),
          const SizedBox(
            height: 18,
          ),
          Expanded(
              child: CustomGridKitchenTypes(
            bloc: bloc,
            kitchenList: currentTypeModel.kitchenList,
            typeId: currentTypeModel.typeId,
            appBarTitle: currentTypeModel.typeName,
          )),
          const SizedBox(
            height: 18,
          ),
          currentTypeModel.itemsCount>10? CustomPaginationWidget(
            length: (currentTypeModel.itemsCount/10).ceil() ,currentPage: bloc.currPageInShowMore, onPageChanged: (int index) {
              bloc.add(ChangePageIndexInShowMoreEvent(index:index ));
              },
          ): const SizedBox(),
        ],
      ),
    );
  }
}