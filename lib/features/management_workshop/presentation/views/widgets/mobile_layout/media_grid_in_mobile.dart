import 'package:al_hassan_warsha/core/utils/functions/extentions.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_media_viewer.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/custom_media_item.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomGridMediaInMobile extends StatelessWidget {
  const CustomGridMediaInMobile(
      {super.key,
      required this.pickedMediaList,
      required this.enableClear,
      this.removeIndex,
      this.addMediaMore});

  final List<PickedMedia> pickedMediaList;
  final bool enableClear;
  final void Function(int)? removeIndex;
  final void Function(List<String>)? addMediaMore;

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    return Column(children: [
      ConstrainedBox(
        constraints: BoxConstraints(maxHeight: context.screenHeight * 0.4),
        child: GridView.builder(
            padding: EdgeInsets.zero,
            itemCount: pickedMediaList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: 1.25,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomMediaView(
                              medialList: pickedMediaList,
                              initialPage: index)));
                },
                child: CustomMediaItemInOrder(
                    imageWidth: 0.5,
                    pickedMedia: pickedMediaList[index],
                    enableClear: enableClear,
                    removeIndex: () {
                      removeIndex != null ? removeIndex!(index) : null;
                    }),
              );
            }),
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
                  addMediaMore != null ? addMediaMore!(list) : null;
                });
              },
              pushButtomText: "إضافة المزيد ",
              padding: const EdgeInsets.all(12),
              enableIcon: false,
              pushButtomTextFontSize: 16,
              borderRadius: 14,
            ))
          : const SizedBox()
    ]);
  }
}
