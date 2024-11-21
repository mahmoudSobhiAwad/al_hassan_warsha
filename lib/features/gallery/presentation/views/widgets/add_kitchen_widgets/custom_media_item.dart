
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/custom_video_item.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/small_kitchen_image.dart';
import 'package:flutter/material.dart';

StatelessWidget getCustomMedia({
  required PickedMedia pickedMedia,
}) {
  return switch (pickedMedia.mediaType) {
    MediaType.image => CustomSmallImageWithCustomWidth(
        widthOfImage: 0.2,
        pickedMedia: pickedMedia,
      ),
    MediaType.video => const CustomVideoItem(),
    MediaType.unknown => const Text("Some Error"),
  };
}
