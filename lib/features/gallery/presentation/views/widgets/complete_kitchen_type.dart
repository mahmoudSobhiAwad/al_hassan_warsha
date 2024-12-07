import 'package:al_hassan_warsha/core/utils/functions/extentions.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_type.dart';
import 'package:al_hassan_warsha/features/gallery/data/pages_gallery_enum.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/bloc/gallery_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_new_type_with_kitchen_name.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/one_kitchen_list.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/show_more_kitchen_circle.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/view_type_kitchen_view.dart';
import 'package:flutter/material.dart';

class CompleteKitchenType extends StatelessWidget {
  const CompleteKitchenType({super.key,required this.changeShowMore,required this.model,required this.bloc,});
  final void Function()changeShowMore;
  final KitchenTypeModel model;
 
  final GalleryBloc bloc;
 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddnewTypeWithKitchenName(model: model,bloc: bloc,),
        const SizedBox(
          height: 16,
        ),
        model.itemsCount==0
            ? Column(
                children: [
                  Text(
                    "لا يوجد اي عناصر من هذا النوع",
                    style: AppFontStyles.extraBoldNew24(context),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomPushContainerButton(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ViewKitchenInGalleryView(galleryBloc: bloc,pagesGalleryEnum: PagesGalleryEnum.add,titleOfAppBar: model.typeName,typeId: model.typeId,);
                      }));
                    },
                  ),
                ],
              )
            : SizedBox(
                height:context.screenHeight * 0.2,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: ListOfOneKitchenType(
                        bloc: bloc,
                        kitchenModelList: model.kitchenList,typeName: model.typeName,),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                   model.itemsCount> 5? InkWell(
                        hoverColor: Colors.white,
                        highlightColor: Colors.white,
                        focusColor: Colors.white,
                        splashColor: Colors.white,
                        onTap: (){
                          changeShowMore();
                        },
                        child: const ShowMoreCirlcle()):const SizedBox()
                  ],
                ),
              ),
      ],
    );
  }
}

