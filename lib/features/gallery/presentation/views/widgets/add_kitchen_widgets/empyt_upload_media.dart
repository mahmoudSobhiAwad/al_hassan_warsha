import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EmptyUploadMedia extends StatelessWidget {
  const EmptyUploadMedia({super.key, this.addMedia});
  final void Function(List<String>)? addMedia;

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();

    return InkWell(
      onTap: () async {
        addMedia != null
            ? {
                await picker.pickMultipleMedia().then((values) {
                  List<String> list = [];
                  for (var item in values) {
                    list.add(item.path);
                  }
                  addMedia!(list);
                })
              }
            : () {};
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 70),
        decoration: BoxDecoration(
          color: AppColors.veryLightGray,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ارفع بعض الصور ومقاطع الفيديو حتي تعرض المنتج بأفضل صورة ممكنة ",
              style: AppFontStyles.extraBoldNew24(context),
            ),
            const Icon(
              Icons.cloud_upload,
              size: 50,
            )
          ],
        ),
      ),
    );
  }
}
