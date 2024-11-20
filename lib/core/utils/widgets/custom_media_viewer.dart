import 'dart:io';

import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_video_player.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:flutter/material.dart';

class CsutomMediaView extends StatefulWidget {
  const CsutomMediaView(
      {super.key, required this.medialList, required this.initialPage});
  final List<PickedMedia> medialList;
  final int initialPage;

  @override
  State<CsutomMediaView> createState() => _CsutomMediaViewState();
}

class _CsutomMediaViewState extends State<CsutomMediaView> {
  late PageController controller;
  @override
  void initState() {
    controller = PageController(initialPage: widget.initialPage);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            toolbarHeight: 100,
            backgroundColor: AppColors.blue,
            title: Text(
              "عرض الوسائط ",
              style: AppFontStyles.extraBold40(context)
                  .copyWith(color: AppColors.white),
            ),
            titleSpacing: 40,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 40,
                  color: AppColors.white,
                )),
          ),
          body: SafeArea(
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      controller.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.bounceInOut);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 40,
                    )),
                Expanded(
                    child: PageView.builder(
                        physics:const NeverScrollableScrollPhysics(),
                        controller: controller,
                        itemCount: widget.medialList.length,
                        itemBuilder: (context, index) {
                          switch (widget.medialList[index].mediaType) {
                            case MediaType.image:
                              return InteractiveViewer(
                                
                                child: Image.file(
                                  File(widget.medialList[index].mediaPath),
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Text("Error in displaying media"),
                                ),
                              );
                            case MediaType.video:
                              return CustomVideoPlayer(
                                  videoPath:
                                      widget.medialList[index].mediaPath);
                            case MediaType.unknown:
                              return const Text("media Error Error");
                          }
                        })),
                IconButton(
                    onPressed: () {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.bounceInOut);
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 40,
                    )),
              ],
            ),
          )),
    );
  }
}

