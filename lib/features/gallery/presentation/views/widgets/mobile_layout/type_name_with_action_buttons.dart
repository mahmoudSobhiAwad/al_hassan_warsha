
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_type.dart';
import 'package:flutter/material.dart';

class TypeNameWithActionsInMobileLayout extends StatelessWidget {
  const TypeNameWithActionsInMobileLayout(
      {super.key,
      required this.model,
      required this.showAllItems,
      required this.deletAllKitchens,
      required this.moveToAddNew});
  final KitchenTypeModel model;
  final void Function() showAllItems;
  final void Function() moveToAddNew;
  final void Function() deletAllKitchens;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: SizedBox(),
        ),
        Expanded(
          flex: 4,
          child: Row(
            children: [
              Text(
                model.typeName,
                style: AppFontStyles.extraBold18(context).copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                "${model.itemsCount}",
                style: AppFontStyles.extraBold20(context)
                    .copyWith(color: AppColors.lightGray1),
              ),
            ],
          ),
        ),
        const Expanded(
          flex: 7,
          child: SizedBox(),
        ),
        PopupMenuButton(
            color: AppColors.white,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: showAllItems,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "عرض الكل ",
                        style: AppFontStyles.extraBold16(context),
                      ),
                      const IconButton(
                          onPressed: null,
                          icon: Icon(Icons.close_fullscreen_rounded)),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: moveToAddNew,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "اضافة جديد",
                        style: AppFontStyles.extraBold16(context),
                      ),
                      const IconButton(
                          onPressed: null, icon: Icon(Icons.create)),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: deletAllKitchens,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "حذف الكل",
                        style: AppFontStyles.extraBold16(context)
                            .copyWith(color: AppColors.red),
                      ),
                      const IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.delete,
                            color: AppColors.red,
                          )),
                    ],
                  ),
                ),
              ];
            }),
        const Expanded(
          child: SizedBox(),
        ),
      ],
    );
  }
}

