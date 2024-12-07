import 'package:al_hassan_warsha/core/utils/functions/extentions.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_type.dart';
import 'package:al_hassan_warsha/features/gallery/data/pages_gallery_enum.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/bloc/gallery_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/action_types_in_dialog.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/mobile_layout/type_name_with_action_buttons.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/one_kitchen_list.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/view_type_kitchen_view.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/alert_to_check_db.dart';
import 'package:flutter/material.dart';

class CompleteKitchenTypeInMobileLayout extends StatelessWidget {
  const CompleteKitchenTypeInMobileLayout(
      {super.key,
      required this.model,
      required this.bloc,
      required this.index});
  final KitchenTypeModel model;
  final GalleryBloc bloc;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TypeNameWithActionsInMobileLayout(
          model: model,
          showAllItems: () {
            bloc.add(ShowMoreKitcenTypeEvent(
                currIndex: index, typeId: model.typeId, isOpen: true));
          },
          deletAllKitchens: () {
            showDialog(
                context: context,
                builder: (context) {
                  return const Dialog(
                    child: CustomAlert(
                      iconSize: 45,
                      titleSize: 20,
                      title:
                          "هل انت متأكد من حذف هذا النوع ؟ سيتم حذف جميع المطابخ الموجوده به !! ",
                      actionButtonsInstead: DialogAddNewTypeActionButton(
                        text_1: "تأكيد",
                        text_2: "الغاء",
                      ),
                    ),
                  );
                });
          },
          moveToAddNew: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewKitchenInGalleryView(
                          galleryBloc: bloc,
                          pagesGalleryEnum: PagesGalleryEnum.add,
                          titleOfAppBar: model.typeName,
                          typeId: model.typeId,
                        )));
          },
        ),
        const SizedBox(
          height: 16,
        ),
        model.itemsCount == 0
            ? Column(
                children: [
                  Text(
                    "لا يوجد اي عناصر من هذا النوع",
                    style: AppFontStyles.extraBoldNew18(context),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomPushContainerButton(
                    pushButtomTextFontSize: 20,
                    borderRadius: 12,
                    iconSize: 24,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ViewKitchenInGalleryView(
                          galleryBloc: bloc,
                          pagesGalleryEnum: PagesGalleryEnum.add,
                          titleOfAppBar: model.typeName,
                          typeId: model.typeId,
                        );
                      }));
                    },
                  ),
                ],
              )
            : SizedBox(
                height: context.screenHeight * 0.2,
                child: ListOfOneKitchenType(
                  imageWidth: .33,
                  bloc: bloc,
                  kitchenModelList: model.kitchenList,
                  typeName: model.typeName,
                ),
              ),
      ],
    );
  }
}

