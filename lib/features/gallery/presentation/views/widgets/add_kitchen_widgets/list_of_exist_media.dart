import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/custom_video_item.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/small_kitchen_image.dart';
import 'package:flutter/material.dart';

class MediaListExist extends StatelessWidget {
  const MediaListExist({super.key, required this.pickedList});
  final List<PickedMedia> pickedList;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 300),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(right: 15),
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              ...List.generate(
                  pickedList.length,
                  (index) => Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: switch (pickedList[index].mediaType) {
                        MediaType.image => CustomSmallImageWithCustomWidth(
                            widthOfImage: 0.2,
                            pickedMedia: pickedList[index],
                          ),
                        MediaType.video => const CustomVideoItem(),
                        MediaType.unknown => const Text("Some Error"),
                      }))
            ]),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        const Center(
            child: CustomPushContainerButton(
          pushButtomText: "إضافة المزيد ",
          padding: EdgeInsets.all(12),
          enableIcon: false,
          borderRadius: 14,
        ))
      ],
    );
  }
}


