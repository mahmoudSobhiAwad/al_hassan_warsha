import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/custom_video_item.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/small_kitchen_image.dart';
import 'package:flutter/material.dart';

class CustomMediaItemInOrder extends StatelessWidget {
  const CustomMediaItemInOrder(
      {super.key,
      required this.pickedMedia,
      required this.enableClear,
      required this.removeIndex,
      this.imageWidth});

  final PickedMedia pickedMedia;
  final bool enableClear;
  final void Function()? removeIndex;
  final double? imageWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        getCustomMedia(pickedMedia: pickedMedia, imageWidth: imageWidth),
        enableClear
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                  child: IconButton(
                      onPressed: removeIndex,
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.red,
                      )),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

StatelessWidget getCustomMedia({
  required PickedMedia pickedMedia,
  double? imageWidth,
}) {
  return switch (pickedMedia.mediaType) {
    MediaType.image => CustomSmallImageWithCustomWidth(
        widthOfImage: imageWidth ?? 0.2,
        pickedMedia: pickedMedia,
      ),
    MediaType.video => CustomVideoItem(
        width: imageWidth,
      ),
    MediaType.unknown => const Text("Some Error"),
  };
}
