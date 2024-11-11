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
      create: (context) => GalleryBloc(),
      child:
          BlocConsumer<GalleryBloc, GalleryState>(listener: (context, state) {
        if (state is ShowMoreOfKitchenTypeState) {
          showMoreKitchens = state.showMore;
        }
      }, builder: (context, state) {
        var galleryBloc = context.read<GalleryBloc>();

        return Expanded(
          child: Row(
            children: [
              const Expanded(child: SideBarGallery()),
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
        );
      }),
    );
  }
}
