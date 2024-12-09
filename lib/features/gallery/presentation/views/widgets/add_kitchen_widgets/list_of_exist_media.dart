import 'package:al_hassan_warsha/core/utils/functions/extentions.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_media_viewer.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/custom_media_item.dart';
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
            constraints: BoxConstraints(
              maxHeight: context.screenHeight * 0.2,
            ),
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomMediaView(
                                  medialList: pickedList, initialPage: index)));
                    },
                    child: CustomMediaItemInOrder(
                        pickedMedia: pickedList[index],
                        enableClear: enableClear,
                        removeIndex: () {
                          removeIndex != null ? removeIndex!(index) : null;
                        }),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 16,
                  );
                },
                itemCount: pickedList.length)),
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
