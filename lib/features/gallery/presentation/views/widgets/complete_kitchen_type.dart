import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_type.dart';
import 'package:al_hassan_warsha/features/gallery/data/pages_gallery_enum.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_new_type_with_kitchen_name.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/one_kitchen_list.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/show_more_kitchen_circle.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/view_type_kitchen_view.dart';
import 'package:flutter/material.dart';

class CompleteKitchenType extends StatelessWidget {
  const CompleteKitchenType({super.key,required this.changeShowMore,required this.model});
  final void Function(bool show)changeShowMore;
  final KitchenTypeModel model;
 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddnewTypeWithKitchenName(model: model,),
        const SizedBox(
          height: 16,
        ),
        model.itemsCount==0
            ? Column(
                children: [
                  Text(
                    "لا يوجد اي عناصر من هذا النوع",
                    style: AppFontStyles.extraBold30(context),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomPushContainerButton(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ViewKitchenInGalleryView(pagesGalleryEnum: PagesGalleryEnum.add,titleOfAppBar: model.typeName,typeId: model.typeId,);
                      }));
                    },
                  ),
                ],
              )
            : SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.2,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListOfOneKitchenType(kitchenModelList: model.kitchenList,typeName: model.typeName,),
                    const SizedBox(
                      width: 16,
                    ),
                   model.itemsCount> 5? InkWell(
                        hoverColor: Colors.white,
                        highlightColor: Colors.white,
                        focusColor: Colors.white,
                        splashColor: Colors.white,
                        onTap: (){
                          changeShowMore(true);
                        },
                        child: const ShowMoreCirlcle()):const SizedBox()
                  ],
                ),
              ),
      ],
    );
  }
}
