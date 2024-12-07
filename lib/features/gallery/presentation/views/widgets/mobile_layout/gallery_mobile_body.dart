import 'package:al_hassan_warsha/core/utils/widgets/empty_data_screen.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/bloc/gallery_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/add_new_type_dialog.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/all_kitchen_items_body.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/gallery_body.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/mobile_layout/complete_type.dart';
import 'package:flutter/material.dart';

class GalleryMobileBody extends StatelessWidget {
  const GalleryMobileBody({super.key, required this.bloc});
  final GalleryBloc bloc;
  @override
  Widget build(BuildContext context) {
    return bloc.enableMoreWidget
        ? Expanded(
            child: ShowingAllKitchenItemsGrid(
              fontSize: 20,
              borderRadius: 12,
              items: [
                bloc.currentShowMoreModel.typeName,
              ],
              fontSizeInButtons: 16,
              iconSize: 24,
              crossAxisCount: 2,
              imageWidth: 0.4,
              aspectRatio: 1.25,
              currentTypeModel: bloc.currentShowMoreModel,
              bloc: bloc,
            ),
          )
        : bloc.basickitchenTypesList.isNotEmpty
            ? Expanded(
                child: GalleryBody(
                completeKitchenTypeInstead: ({required index, required model}) {
                  return CompleteKitchenTypeInMobileLayout(
                    model: model,
                    bloc: bloc,
                    index: index,
                  );
                },
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
              );
  }
}
