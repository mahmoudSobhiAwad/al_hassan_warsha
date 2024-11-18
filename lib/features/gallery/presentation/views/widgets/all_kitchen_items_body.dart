import 'package:al_hassan_warsha/core/utils/widgets/custom_pagination.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/data/pages_gallery_enum.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/bloc/gallery_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/gride_view_list.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/app_bar_with_linking.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/view_type_kitchen_view.dart';
import 'package:flutter/material.dart';

class ShowingAllKitchenItemsGrid extends StatelessWidget {
  const ShowingAllKitchenItemsGrid({super.key,required this.bloc,required this.onBack,required this.kitchenList,required this.typeName,required this.typeId});
  
  final GalleryBloc bloc;
  final List<KitchenModel>kitchenList;
  final String typeName;
  final void Function()onBack;
  final String typeId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
      child: Column(
        children: [
          AppBarWithLinking(
            onBack:onBack ,
            items: [
            "الرئيسية",
             typeName,
          ]),
         
           Align(
            alignment: Alignment.centerLeft,
            child: CustomPushContainerButton(pushButtomText: "اضافة مطبخ جديد",onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewKitchenInGalleryView(galleryBloc: bloc,pagesGalleryEnum: PagesGalleryEnum.add,typeId:typeId,titleOfAppBar: typeName,)));
            },)),
          const SizedBox(height: 18,),
          Expanded(child:CustomGridKitchenTypes(bloc: bloc,kitchenList:kitchenList,typeId: typeId,appBarTitle: typeName,)),
          const SizedBox(height: 18,),
          const CustomPaginationWidget()
        ],
      ),
    );
  }
}