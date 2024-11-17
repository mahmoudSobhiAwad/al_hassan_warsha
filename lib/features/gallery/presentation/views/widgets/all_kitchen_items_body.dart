import 'package:al_hassan_warsha/core/utils/widgets/custom_pagination.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/data/pages_gallery_enum.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/bloc/gallery_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/gride_view_list.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/app_bar_with_linking.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/view_type_kitchen_view.dart';
import 'package:flutter/material.dart';

class ShowingAllKitchenItemsGrid extends StatelessWidget {
  const ShowingAllKitchenItemsGrid({super.key,required this.bloc});
  
  final GalleryBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
      child: Column(
        children: [
          AppBarWithLinking(
            onBack:(){
                  bloc.add(ShowMoreKitcenTypeEvent(showMore: false));
                } ,
            items: const [
            "الرئيسية",
             "مطبخ كلاسيك",
          ]),
         
           Align(
            alignment: Alignment.centerLeft,
            child: CustomPushContainerButton(pushButtomText: "اضافة مطبخ جديد",onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewKitchenInGalleryView(galleryBloc: bloc,pagesGalleryEnum: PagesGalleryEnum.add,)));
            },)),
          const SizedBox(height: 18,),
          Expanded(child:CustomGridKitchenTypes(bloc: bloc,)),
          const SizedBox(height: 18,),
          const CustomPaginationWidget()
        ],
      ),
    );
  }
}