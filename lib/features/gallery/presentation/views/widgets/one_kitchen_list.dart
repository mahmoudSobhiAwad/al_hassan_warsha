import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/data/pages_gallery_enum.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/small_kitchen_image.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/view_type_kitchen_view.dart';
import 'package:flutter/material.dart';

class ListOfOneKitchenType extends StatelessWidget {
  const ListOfOneKitchenType({super.key,this.enableInner=true,this.enableClose=false,required this.kitchenModelList,required this.typeName});
  final bool enableInner;
  final bool enableClose;
  final List<KitchenModel>kitchenModelList;
  final String typeName;
  @override
  Widget build(BuildContext context) {
    
    return Expanded(
      flex: 4,
      child: ListView.separated(
        
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=>ViewKitchenInGalleryView(pagesGalleryEnum: PagesGalleryEnum.view,titleOfAppBar:typeName ,kitchenModel: kitchenModelList[index],)));
              },
              child: SmallKitchenTypeImage(widthOfImage: 0.3,enableInner: enableInner,enableClose: enableClose,model: kitchenModelList[index],));
          },
          separatorBuilder: (context, index) => const SizedBox(
                width: 14,
              ),
          itemCount: kitchenModelList.length),
    );
  }
}
