import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_type.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/bloc/gallery_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/complete_kitchen_type.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/latest_added_kitchen_list.dart';
import 'package:flutter/material.dart';

class GalleryBody extends StatefulWidget {
  const GalleryBody({super.key, required this.bloc, required this.kitchenList,this.enableLastAdded=true});
  final GalleryBloc bloc;
  final List<KitchenTypeModel> kitchenList;
  final bool enableLastAdded;

  @override
  State<GalleryBody> createState() => _GalleryBodyState();
}

class _GalleryBodyState extends State<GalleryBody> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          widget.bloc.hasMore) {
        widget.bloc.add(FetchMoreTypesEvent());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Scrollbar(
        radius: const Radius.circular(5),
        thickness: 12,
        thumbVisibility: widget.enableLastAdded,
        trackVisibility: widget.enableLastAdded,
        controller: scrollController,
        scrollbarOrientation: ScrollbarOrientation.right,
        child: ScrollConfiguration(
          behavior:const ScrollBehavior().copyWith(scrollbars: false),
          child: CustomScrollView(
            controller: scrollController,
             slivers: [
          widget.enableLastAdded?  SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.bloc.newestKitchenTypeList.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "المضاف حديثا",
                                style: AppFontStyles.extraBold50(context),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              AutoScrollingPageView(
                                kitchenModelList:
                                    widget.bloc.newestKitchenTypeList,
                                pageController: widget.bloc.pageController,
                              ),
                            ],
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      "انواع المطابخ",
                      style: AppFontStyles.extraBold40(context),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            )
            :const SliverToBoxAdapter(),
           
            widget.bloc.isLoading
                ? const SliverToBoxAdapter(
                    child: SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator()))
                : SliverList.separated(
                    itemBuilder: (context, index) {
                      return CompleteKitchenType(
                        bloc: widget.bloc,
                        model: widget.kitchenList[index],
                        changeShowMore: () {
                          widget.bloc.add(ShowMoreKitcenTypeEvent(
                              currIndex: index,
                              typeId: widget.kitchenList[index].typeId,
                              isOpen: true));
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 20,
                      );
                    },
                    itemCount: widget.kitchenList.length,
                  ),
            widget.bloc.showMoreIndicator
                ? const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  )
                : const SliverToBoxAdapter(),
          ]),
        ),
      ),
    );
  }
}
