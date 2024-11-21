import 'package:al_hassan_warsha/core/utils/functions/service_locator.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_media_viewer.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/data/repos/fetch_media_gallery/fetch_medi.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/cubit/media_gallery_grid_cubit.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/custom_media_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowMoreMediaGridView extends StatelessWidget {
  const ShowMoreMediaGridView({super.key, required this.kitchenId});
  final String kitchenId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MediaGalleryGridCubit(
          kitchenId: kitchenId,
          fetchMediaRepoImpl: getIt.get<FetchMediaRepoImpl>())..fetchForFirstTime()..addListener(),
      child: BlocBuilder<MediaGalleryGridCubit, MediaGalleryGridState>(
          builder: (context, state) {
        var bloc = context.read<MediaGalleryGridCubit>();
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Scaffold(
                backgroundColor: AppColors.white,
                body: bloc.isLoading
                    ? const CircularProgressIndicator()
                    : Padding(
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
                                  controller: bloc.controller,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: bloc.pickedList.length,
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
                                                              bloc.pickedList,
                                                          initialPage: index)));
                                        },
                                        child: getCustomMedia(
                                            pickedMedia:
                                                bloc.pickedList[index]));
                                  }),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            bloc.isLoadingMore
                                ? const CircularProgressIndicator()
                                : const SizedBox(),
                          ],
                        ),
                      )),
          ),
        );
      }),
    );
  }
}

List<PickedMedia> getList(List<KitchenMedia> mediaList) {
  List<PickedMedia> pickedList = [];
  for (var item in mediaList) {
    pickedList.add(item.toPicekedMedi());
  }
  return pickedList;
}
