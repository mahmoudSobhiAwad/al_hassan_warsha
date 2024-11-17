import 'package:al_hassan_warsha/features/gallery/data/pages_gallery_enum.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/bloc/gallery_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/view_type_kitchen_view.dart';
import 'package:flutter/material.dart';

class CustomGridKitchenTypes extends StatelessWidget {
  const CustomGridKitchenTypes({super.key,required this.bloc});
final GalleryBloc bloc;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 30,crossAxisSpacing: 30,childAspectRatio:350/250),
      itemBuilder: (context,index){
        return InkWell(
          onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewKitchenInGalleryView(pagesGalleryEnum: PagesGalleryEnum.view,galleryBloc: bloc,)));
          },
         // child: const SmallKitchenTypeImage(widthOfImage: 0.3,),
          );
      },
      itemCount: 4,);
  }
}
