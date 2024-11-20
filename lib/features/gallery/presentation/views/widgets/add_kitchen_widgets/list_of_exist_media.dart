import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_media_viewer.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/custom_video_item.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/small_kitchen_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MediaListExist extends StatelessWidget {
  const MediaListExist(
      {super.key,
      required this.pickedList,
      required this.enableClear,
      this.addMore,
      this.removeIndex});
  final List<PickedMedia> pickedList;
  final bool enableClear;
  final void Function(int)? removeIndex;
  final void Function(List<String>)? addMore;
  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
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
                  (index) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CsutomMediaView(
                                      medialList: pickedList,
                                      initialPage: index)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Stack(
                            children: [
                              switch (pickedList[index].mediaType) {
                                MediaType.image =>
                                  CustomSmallImageWithCustomWidth(
                                    widthOfImage: 0.2,
                                    pickedMedia: pickedList[index],
                                  ),
                                MediaType.video => const CustomVideoItem(),
                                MediaType.unknown => const Text("Some Error"),
                              },
                              enableClear
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.white,
                                        ),
                                        child: IconButton(
                                            onPressed: () {
                                              removeIndex != null
                                                  ? removeIndex!(index)
                                                  : () {};
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                              color: AppColors.red,
                                            )),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ))
            ]),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        enableClear
            ? Center(
                child: CustomPushContainerButton(
                onTap: () async {
                  await picker.pickMultipleMedia().then((values) {
                    List<String> list = [];
                    for (var item in values) {
                      list.add(item.path);
                    }
                    addMore != null ? addMore!(list) : null;
                  });
                },
                pushButtomText: "إضافة المزيد ",
                padding: const EdgeInsets.all(12),
                enableIcon: false,
                borderRadius: 14,
              ))
            : const SizedBox()
      ],
    );
  }
}
