import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/gallery_body.dart';
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
            child: GalleryBody(),
          ),
        ],
      ),
    );
  }
}



