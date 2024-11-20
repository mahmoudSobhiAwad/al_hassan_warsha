import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_type.dart';
import 'package:al_hassan_warsha/features/gallery/data/pages_gallery_enum.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/bloc/gallery_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/view_type_kitchen_view.dart';
import 'package:flutter/material.dart';

class AddnewTypeWithKitchenName extends StatelessWidget {
  const AddnewTypeWithKitchenName(
      {super.key, required this.model, required this.bloc});
  final KitchenTypeModel model;
  final GalleryBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: SizedBox(),
        ),
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: Text(
              model.typeName,
              style: AppFontStyles.extraBold28(context).copyWith(
                overflow: TextOverflow.ellipsis,
              ),
            ),
            title: Text(
              "${model.itemsCount}",
              style: AppFontStyles.extraBold20(context)
                  .copyWith(color: AppColors.lightGray1),
            ),
          ),
        ),
        const Expanded(
          flex: 7,
          child: SizedBox(),
        ),
        model.itemsCount != 0
            ? TextButton(
                onPressed: () {
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
                child: Text(
                  "إضافة جديد",
                  style: AppFontStyles.extraBold30(context)
                      .copyWith(color: AppColors.blue),
                ))
            : const SizedBox(),
        const Expanded(
          child: SizedBox(),
        ),
      ],
    );
  }
}
