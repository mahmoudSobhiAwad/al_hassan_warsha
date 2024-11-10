import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_adaptive_layout.dart';
import 'package:al_hassan_warsha/features/gallery/data/pages_gallery_enum.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/view_edit_add_bloc/bloc/view_edit_add_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/custom_kitchen_gallery_parent.dart';
import 'package:al_hassan_warsha/features/home/presentation/manager/bloc/home_basic_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewKitchenInGalleryView extends StatelessWidget {
  const ViewKitchenInGalleryView({
    super.key,
    required this.pagesGalleryEnum,
  });
  final PagesGalleryEnum pagesGalleryEnum;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) => ViewEditAddBloc(pagesGalleryEnum: pagesGalleryEnum),
        child: BlocConsumer<ViewEditAddBloc, ViewEditAddState>(
            builder: (context, state) {
              var bloc=context.read<ViewEditAddBloc>();
              return SafeArea(
                child: Scaffold(
                  backgroundColor: AppColors.white,
                  body: CustomAdaptiveLayout(
                    desktopLayout: (context) => KitchenGalleryCustomView(
                      bloc: bloc,
                    ),
                    mobileLayout: (context) => const Text("Mobile Layout"),
                    tabletLayout: (context) => const Text("Tablet Layout"),
                  ),
                ),
              );
            },
            listener: (context,state){
              if(state is ChangeBarIndexState){
                context.read<HomeBasicBloc>().add(ChangeCurrentPageEvent(currIndex: state.barIndex));
              }

            }),
      ),
    );
  }
}
