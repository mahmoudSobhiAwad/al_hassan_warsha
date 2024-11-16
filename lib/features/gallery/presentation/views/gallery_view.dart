import 'package:al_hassan_warsha/core/utils/functions/service_locator.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/bloc/gallery_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/all_kitchen_items_body.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/gallery_body.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/side_bar_gallery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryView extends StatelessWidget {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    bool showMoreKitchens = false;
    return BlocProvider(
      create: (context) => GalleryBloc(galleryRepoImp: getIt.get())
        ..add(CheckExistOfGalleryDataEvent()),
      child:
          BlocConsumer<GalleryBloc, GalleryState>(listener: (context, state) {
        if (state is ShowMoreOfKitchenTypeState) {
          showMoreKitchens = state.showMore;
        } else if (state is SuccessAddedNewKitchenType) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColors.green,
            content: Text(
              "تم اضافة نوع جديد",
              style: AppFontStyles.extraBold20(context)
                  .copyWith(color: AppColors.white),
            ),
          ));
        } else if (state is FailureCreateOrGetData) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColors.red,
            content: Text(
              "${state.errMessage}",
              style: AppFontStyles.extraBold20(context)
                  .copyWith(color: AppColors.white),
            ),
          ));
        }
        else if (state is FailureAddedNewKitchenType) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColors.red,
            content: Text(
              "${state.errMessage}",
              style: AppFontStyles.extraBold20(context)
                  .copyWith(color: AppColors.white),
            ),
          ));
        }
      }, builder: (context, state) {
        var galleryBloc = context.read<GalleryBloc>();
        switch (state.runtimeType) {
          case const (LoadingCreateOrGetData):
          
          return const CircularProgressIndicator();
          case const (SuccessCreateOrGetData):
          final successState = state as SuccessCreateOrGetData;
          return Expanded(
          child: Row(
            children: [
              Expanded(child: SideBarGallery(
                addType: (value){
                  galleryBloc.add(AddNewKitchenTypeEvent(typeName: value));
                },
                typesList: successState.kitchenTypesList,)),
              Expanded(
                flex: 4,
                child: showMoreKitchens
                    ? ShowingAllKitchenItemsGrid(
                        bloc: galleryBloc,
                      )
                    : GalleryBody(
                        bloc: galleryBloc,
                      ),
              ),
            ],
          ),
        ) ;
        case  const (FailureCreateOrGetData):
        final failedStated=state as FailureCreateOrGetData;
        return Text("${failedStated.errMessage}");
        default:
        return const SizedBox();
        }
        
      }),
    );
  }
}
