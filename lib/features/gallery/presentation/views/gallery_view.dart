import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/kitchen_item_type.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/latest_added_kitchen_list.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/side_bar_gallery.dart';
import 'package:flutter/material.dart';

class GalleryView extends StatelessWidget {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Row(
        children: [
          SideBarGallery(),
          Expanded(
            flex: 4,
            child: GalleryBody(
            ),
          ),
        ],
      ),
    );
  }
}

class GalleryBody extends StatelessWidget {
  const GalleryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("المضاف حديثا",style: AppFontStyles.extraBold50(context),),
          const SizedBox(height: 8,),
          const AutoScrollingPageView(),
          const SizedBox(height: 24,),
          Text("انواع المطابخ",style: AppFontStyles.extraBold40(context),),
          const SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(child: SizedBox(),),
              const KitchenTypeItem(mainAxisAlignment: MainAxisAlignment.spaceBetween,),
              const Expanded(flex: 4,child: SizedBox(),),
              TextButton(onPressed: null, child: Text("إضافة جديد",style: AppFontStyles.extraBold30(context).copyWith(color:AppColors.blue),)),
              const Expanded(child: SizedBox(),),
            ],
          ),
          const SizedBox(height: 8,),
        ],
      ),
    );
  }
}




