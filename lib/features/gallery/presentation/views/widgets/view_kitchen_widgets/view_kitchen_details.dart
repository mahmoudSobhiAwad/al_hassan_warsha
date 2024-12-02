import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_container_with_above_text.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/view_edit_add_bloc/bloc/view_edit_add_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/action_types_in_dialog.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/empyt_upload_media.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/list_of_exist_media.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/show_more_media_grid.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/alert_to_check_db.dart';
import 'package:flutter/material.dart';

class ViewKitchenDetailsBody extends StatelessWidget {
  const ViewKitchenDetailsBody(
      {super.key,
      required this.changeEditState,
      required this.kitchenModel,
      required this.bloc,
      required this.deleteKitchen});
  final void Function(bool enableEdit) changeEditState;
  final void Function() deleteKitchen;
  final ViewEditAddBloc bloc;
  final KitchenModel? kitchenModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  kitchenModel?.kitchenName ?? "",
                  style: AppFontStyles.extraBold40(context),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const Expanded(flex: 2, child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomPushContainerButton(
                    onTap: () {
                      changeEditState(true);
                    },
                    iconBehind: Icons.create_rounded,
                    borderRadius: 16,
                    pushButtomText: "تعديل",
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  CustomPushContainerButton(
                    onTap: () {
                      showDialog(
                          context: context,
                          useSafeArea: true,
                          builder: (context) {
                            return Dialog(
                              child: CustomAlert(
                                title: "هل أنت متأكد من حذف هذا المطبخ ؟",
                                enableIcon: false,
                                actionButtonsInstead:
                                    DialogAddNewTypeActionButton(
                                  onPressed_1: deleteKitchen,
                                  onPressed_2: () {
                                    Navigator.pop(context);
                                  },
                                  text_1: "حذف",
                                  text_2: "إلغاء",
                                  color_1: AppColors.red,
                                  color_2: AppColors.green,
                                ),
                              ),
                            );
                          });
                    },
                    borderRadius: 16,
                    color: AppColors.red,
                    childInstead: bloc.isLoding
                        ? const CircularProgressIndicator(
                            color: AppColors.white,
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "حذف",
                                style: AppFontStyles.extraBold30(context)
                                    .copyWith(color: AppColors.white),
                              ),
                              const IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    size: 32,
                                    Icons.delete,
                                    color: AppColors.white,
                                  )),
                            ],
                          ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          CustomContainerWithTextAbove(
            textAbove: "الوصف",
            describtionInCont: kitchenModel?.kitchenDesc ?? "",
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomPushContainerButton(
                enableIcon: false,
                pushButtomText: "الوسائط",
                padding: EdgeInsets.all(20),
              ),
              const SizedBox(
                width: 12,
              ),
              Text("( ${kitchenModel?.mediaCounter} )",
                  style: AppFontStyles.extraBold30(context)),
              const Spacer(),
              kitchenModel!.mediaCounter > 5
                  ? TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowMoreMediaGridView(
                                      kitchenId: kitchenModel!.kitchenId,
                                    )));
                      },
                      child: Text(
                        "عرض المزيد",
                        style: AppFontStyles.extraBold30(context)
                            .copyWith(color: AppColors.blue),
                      ))
                  : const SizedBox()
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          kitchenModel!.kitchenMediaList.isNotEmpty
              ? MediaListExist(
                  enableClear: false,
                  pickedList: kitchenModel!.getPickedMedia(),
                )
              : const EmptyUploadMedia(),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
