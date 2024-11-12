import 'package:al_hassan_warsha/core/utils/widgets/custom_app_bar.dart';
import 'package:al_hassan_warsha/features/gallery/data/pages_gallery_enum.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/view_edit_add_bloc/bloc/view_edit_add_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/add_kitchen_view.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/app_bar_with_linking.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/view_kitchen_details.dart';
import 'package:flutter/material.dart';

class KitchenGalleryCustomView extends StatelessWidget {
  const KitchenGalleryCustomView({super.key,required this.bloc});
  
  final ViewEditAddBloc bloc;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(currIndex: 0, changeIndex: (pageIndex) {
          if(pageIndex!=0){
            Navigator.pop(context);
            bloc.add(ChangeBarIndexEvent(currBarIndex: pageIndex));
          }  
        }),
        const SizedBox(
          height: 24,
        ),
         Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarWithLinking(
                  items:  [
                    "الرئيسية",
                     "مطبخ كلاسيك",
                    bloc.pagesGalleryEnum==PagesGalleryEnum.add?"إضافة مطبخ": "مطبخ رقم 1",
                  ],
                  onBack: (){
                    switch(bloc.pagesGalleryEnum){
                      
                      case PagesGalleryEnum.view:
                        Navigator.pop(context);
                        break;
                      case PagesGalleryEnum.edit:
                        bloc.add(OpenKitchenForEditEvent(enableEdit: false));
                        break;
                      case PagesGalleryEnum.add:
                        Navigator.pop(context);
                    }
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                switch(bloc.pagesGalleryEnum){
                  PagesGalleryEnum.view => ViewKitchenDetailsBody(changeEditState: (edit){
                    bloc.add(OpenKitchenForEditEvent(enableEdit: edit));
                  },),
                  PagesGalleryEnum.edit => const Text("Edit is here"),
                  PagesGalleryEnum.add => const AddKitchenView(),
                },
                
              ],
            ),
          ),
        ),
      ],
    );
  }
}