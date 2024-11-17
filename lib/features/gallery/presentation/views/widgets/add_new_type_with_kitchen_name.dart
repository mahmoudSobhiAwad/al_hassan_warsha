import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_type.dart';
import 'package:al_hassan_warsha/features/gallery/data/pages_gallery_enum.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/kitchen_item_type.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/view_type_kitchen_view.dart';
import 'package:flutter/material.dart';

class AddnewTypeWithKitchenName extends StatelessWidget {
  const AddnewTypeWithKitchenName({super.key,required this.model});
final KitchenTypeModel model;
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
          child: KitchenTypeItem(
            model:model ,
            enableUnderline: false,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
        ),
        const Expanded(flex: 7,child: SizedBox(),),
       model.itemsCount!=0? TextButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewKitchenInGalleryView(pagesGalleryEnum: PagesGalleryEnum.add,titleOfAppBar:model.typeName ,typeId:model.typeId ,)));
            },
            child: Text(
              "إضافة جديد",
              style: AppFontStyles.extraBold30(context)
                  .copyWith(color: AppColors.blue),
            )):const SizedBox(),
        const Expanded(
          child: SizedBox(),
        ),
      ],
    );
  }
}
