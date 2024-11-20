import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/data/pages_gallery_enum.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/bloc/gallery_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/small_kitchen_image.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/view_type_kitchen_view.dart';
import 'package:flutter/material.dart';

class ListOfOneKitchenType extends StatelessWidget {
  const ListOfOneKitchenType({super.key,this.enableInner=true,required this.bloc,this.enableClose=false,required this.kitchenModelList,required this.typeName});
  final bool enableInner;
  final bool enableClose;
  final List<KitchenModel>kitchenModelList;
  final String typeName;
  final GalleryBloc bloc;
  @override
  Widget build(BuildContext context) {
    
    return Expanded(
      flex: 4,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=>ViewKitchenInGalleryView(pagesGalleryEnum: PagesGalleryEnum.view,titleOfAppBar:typeName ,kitchenModel: kitchenModelList[index],galleryBloc: bloc,)));
              },
              child: SmallKitchenTypeImage(enableInner: enableInner,enableClose: enableClose,model: kitchenModelList[index],));
          },
          separatorBuilder: (context, index) => const SizedBox(
                width: 14,
              ),
          itemCount: kitchenModelList.length),
    );
  }
}
