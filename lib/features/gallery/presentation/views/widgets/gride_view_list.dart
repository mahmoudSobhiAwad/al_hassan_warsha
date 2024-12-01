import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/data/pages_gallery_enum.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/bloc/gallery_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/small_kitchen_image.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/view_type_kitchen_view.dart';
import 'package:flutter/material.dart';

class CustomGridKitchenTypes extends StatelessWidget {
  const CustomGridKitchenTypes(
      {super.key, required this.bloc, required this.kitchenList,required this.appBarTitle,required this.typeId});
  final GalleryBloc bloc;
  final List<KitchenModel> kitchenList;
  final String appBarTitle;
  final String typeId;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 5,
          crossAxisSpacing: 30,
          childAspectRatio: 2),
      itemBuilder: (context, index) {
        return InkWell(
          hoverColor: Colors.white,
          highlightColor: Colors.white,
          focusColor: Colors.white,
          splashColor: Colors.white,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewKitchenInGalleryView(
                          pagesGalleryEnum: PagesGalleryEnum.view,
                          galleryBloc: bloc,
                          titleOfAppBar:appBarTitle ,
                          typeId:typeId ,
                          kitchenModel: kitchenList[index],
                        )));
          },
          child: SmallKitchenTypeImage(
            imageWidth: 0.25,
            model: kitchenList[index],
          ),
        );
      },
      itemCount: kitchenList.length,
    );
  }
}
