import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/manager/view_edit_add_bloc/bloc/view_edit_add_bloc.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/empyt_upload_media.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/list_of_exist_media.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:flutter/material.dart';

class AddKitchenView extends StatefulWidget {
  const AddKitchenView({
    super.key,
    required this.bloc,
    required this.typeId,
    required this.mediaList,
  });
  final ViewEditAddBloc bloc;
  final List<PickedMedia> mediaList;
  final String? typeId;

  @override
  State<AddKitchenView> createState() => _AddKitchenViewState();
}

class _AddKitchenViewState extends State<AddKitchenView> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController describController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    controller.dispose();
    describController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: width * 0.5,
                child: CustomColumnWithTextInAddNewType(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "الاسم لا يمكن ان يكون خاليا ";
                    }
                    return null;
                  },
                  controller: controller,
                  textStyle: AppFontStyles.extraBold25(context),
                  text: "الاسم",
                  textLabel: "اضف اسم للمنتج................",
                  enableBorder: true,
                )),
            const SizedBox(
              height: 12,
            ),
            CustomColumnWithTextInAddNewType(
              controller: describController,
              textStyle: AppFontStyles.extraBold25(context),
              maxLine: 2,
              text: "الوصف",
              textLabel:
                  "اضف بعض الوصف للمنتج ليساعدك في شرح المنتج للعميل...................",
              enableBorder: true,
            ),
            const SizedBox(
              height: 22,
            ),
            Row(
              children: [
                Text(
                  "الوسائط",
                  style: AppFontStyles.extraBold25(context),
                ),
                const Spacer(),
                TextButton(
                    onPressed: null,
                    child: Text(
                      "عرض المزيد",
                      style: AppFontStyles.extraBold30(context)
                          .copyWith(color: AppColors.blue),
                    ))
              ],
            ),
            const SizedBox(
              height: 22,
            ),
            widget.mediaList.isNotEmpty
                ? MediaListExist(
                    addMore: (media) {
                      widget.bloc.add(RecieveMediaToAddEvent(
                          medialList: media, isMore: true));
                    },
                    enableClear: true,
                    pickedList: widget.mediaList,
                    removeIndex: (index) {
                      widget.bloc.add(RemovePickedMediaIndexEvent(index: index));
                    },
                  )
                : EmptyUploadMedia(
                    addMedia: (media) {
                      widget.bloc.add(RecieveMediaToAddEvent(medialList: media));
                    },
                  ),
            const SizedBox(
              height: 32,
            ),
            Center(
                child: CustomPushContainerButton(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  widget.bloc.add(AddNewKitchenEvent(
                      kitchenMediaList: widget.mediaList,
                      typeId: widget.typeId ?? "",
                      name: controller.text,
                      desc: describController.text));
                  controller.clear();
                  describController.clear();
                }
              },
              pushButtomText: "إضافة",
              borderRadius: 15,
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 12),
              enableIcon: false,
            )),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
