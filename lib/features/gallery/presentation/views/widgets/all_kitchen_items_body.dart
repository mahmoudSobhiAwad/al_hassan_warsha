import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_pagination.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/data/pages_gallery_enum.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/bloc/gallery_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/gride_view_list.dart';
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
          Row(
            children: [
              Container(
                decoration:const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.veryLightGray,
                ),
                child: IconButton(onPressed: (){
                  bloc.add(ShowMoreKitcenTypeEvent(showMore: false));
                }, icon:const Icon(Icons.arrow_back_ios_rounded,size: 38,),alignment: Alignment.center,),
              ),
              const SizedBox(width: 24,),
              Text("الرئيسية",style: AppFontStyles.extraBold40(context),),
              const IconButton(onPressed: null,icon: Icon(Icons.arrow_forward_ios_rounded,size: 40,)),
              Text("مطبخ كلاسيك",style: AppFontStyles.extraBold40(context),),
            ],
          ),
           Align(
            alignment: Alignment.centerLeft,
            child: CustomPushContainerButton(pushButtomText: "اضافة مطبخ جديد",onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const ViewKitchenInGalleryView(pagesGalleryEnum: PagesGalleryEnum.add,)));
            },)),
          const SizedBox(height: 18,),
          const Expanded(child:CustomGridKitchenTypes()),
          const SizedBox(height: 18,),
          const CustomPaginationWidget()
        ],
      ),
    );
  }
}