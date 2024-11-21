import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_media_viewer.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/view_edit_add_bloc/bloc/view_edit_add_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/custom_media_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowMoreMediaGridView extends StatelessWidget {
  const ShowMoreMediaGridView(
      {super.key, required this.pickedMedia, required this.bloc});
  final List<KitchenMedia> pickedMedia;
  final ViewEditAddBloc bloc;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
              child: Scaffold(
                  backgroundColor: AppColors.white,
                  body: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.lightGray1,
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    size: 40,
                                  )),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text("عرض كل الوسائط ",
                                style: AppFontStyles.extraBold30(context)),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: pickedMedia.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 20,
                                      crossAxisCount: 4),
                              itemBuilder: (context, index) {
                                return InkWell(
                                    hoverColor: AppColors.white,
                                    splashColor: AppColors.white,
                                    focusColor: AppColors.white,
                                    highlightColor: AppColors.white,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CustomMediaView(
                                                      medialList:
                                                          getList(pickedMedia),
                                                      initialPage: index)));
                                    },
                                    child: getCustomMedia(
                                        pickedMedia: pickedMedia[index]
                                            .toPicekedMedi()));
                              }),
                        ),
                      ],
                    ),
                  )),
            ),
          );
        });
  }
}

List<PickedMedia> getList(List<KitchenMedia> mediaList) {
  List<PickedMedia> pickedList = [];
  for (var item in mediaList) {
    pickedList.add(item.toPicekedMedi());
  }
  return pickedList;
}
