
import 'package:al_hassan_warsha/core/utils/widgets/empty_data_screen.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/bloc/gallery_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/add_new_type_dialog.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/all_kitchen_items_body.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/gallery_body.dart';
import 'package:flutter/material.dart';

class TabletGalleryBody extends StatelessWidget {
  const TabletGalleryBody({
    super.key,
    required this.bloc,
  });

  final GalleryBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          bloc.enableMoreWidget
              ? Expanded(
                  flex: 4,
                  child: ShowingAllKitchenItemsGrid(
                    crossAxisCount: 2,
                    imageWidth: 0.4,
                    aspectRatio: 1.4,
                    currentTypeModel: bloc.currentShowMoreModel,
                    bloc: bloc,
                  ),
                )
              : bloc.basickitchenTypesList.isNotEmpty
                  ? Expanded(
                      child: GalleryBody(
                      enableLastAdded: false,
                      kitchenList: bloc.basickitchenTypesList,
                      bloc: bloc,
                    ))
                  : EmptyDataScreen(
                      emptyText: "ليس لديك اي انواع من المطابخ اضف واحدا ",
                      onTap: () {
                        showDialogToAddNewKitchenType(
                          context,
                          formKey: bloc.formKey,
                          controller: bloc.controller,
                          add: () {
                            if (bloc.formKey.currentState!.validate() &&
                                bloc.controller.text.trim().isNotEmpty) {
                              bloc.add(AddNewKitchenTypeEvent());
                            }
                          },
                        );
                      },
                    ),
        ],
      ),
    );
  }
}
