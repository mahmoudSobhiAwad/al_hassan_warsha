import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_media_viewer.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/custom_media_item.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MediaListInEditView extends StatefulWidget {
  const MediaListInEditView(
      {super.key,
      required this.pickedList,
      required this.fetchMoreKitchen,
      required this.addMore,
      required this.enableShowMore,
      required this.removeIndex});
  final List<PickedMedia> pickedList;

  final void Function(int) removeIndex;
  final void Function() fetchMoreKitchen;
  final void Function(List<String>) addMore;
  final bool enableShowMore;

  @override
  State<MediaListInEditView> createState() => _MediaListInEditViewState();
}

class _MediaListInEditViewState extends State<MediaListInEditView> {
  ImagePicker picker = ImagePicker();
  final ScrollController controller = ScrollController();
  @override
  void initState() {
    controller.addListener(() {
      if (controller.position.pixels >= controller.position.maxScrollExtent &&
          widget.enableShowMore) {
        widget.fetchMoreKitchen();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.2,
            ),
            child: ListView.separated(
                controller: controller,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomMediaView(
                                  medialList: widget.pickedList,
                                  initialPage: index)));
                    },
                    child: Stack(
                      children: [
                        getCustomMedia(pickedMedia: widget.pickedList[index]),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.white,
                            ),
                            child: IconButton(
                                onPressed: () {
                                  widget.removeIndex(index);
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: AppColors.red,
                                )),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 16,
                  );
                },
                itemCount: widget.pickedList.length)),
        const SizedBox(
          height: 12,
        ),
        Center(
            child: CustomPushContainerButton(
          onTap: () async {
            await picker.pickMultipleMedia().then((values) {
              List<String> list = [];
              for (var item in values) {
                list.add(item.path);
              }
              widget.addMore(list);
            });
          },
          pushButtomText: "إضافة المزيد ",
          padding: const EdgeInsets.all(12),
          enableIcon: false,
          borderRadius: 14,
        ))
      ],
    );
  }
}
