import 'package:al_hassan_warsha/features/gallery/data/pages_gallery_enum.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/small_kitchen_image.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/add_new_kitchen_view.dart';
import 'package:flutter/material.dart';

class CustomGridKitchenTypes extends StatelessWidget {
  const CustomGridKitchenTypes({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 30,crossAxisSpacing: 30,childAspectRatio:350/250),
      itemBuilder: (context,index){
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>const ViewKitchenInGalleryView(pagesGalleryEnum: PagesGalleryEnum.view,)));
            },
            child: const SmallKitchenTypeImage(widthOfImage: 0.3,)),
        );
      },
      itemCount: 4,);
  }
}
