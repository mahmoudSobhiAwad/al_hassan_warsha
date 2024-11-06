import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_new_type_with_kitchen_name.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/one_kitchen_list.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/show_more_kitchen_circle.dart';
import 'package:flutter/material.dart';

class CompleteKitchenType extends StatelessWidget {
  const CompleteKitchenType({super.key, this.isEmpty = false});
  final bool isEmpty;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AddnewTypeWithKitchenName(),
        const SizedBox(
          height: 16,
        ),
        isEmpty
            ? Column(
                children: [
                  Text(
                    "لا يوجد اي عناصر من هذا النوع",
                    style: AppFontStyles.extraBold30(context),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomPushContainerButton(),
                ],
              )
            : SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.2,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListOfOneKitchenType(),
                    SizedBox(
                      width: 16,
                    ),
                    ShowMoreCirlcle()
                  ],
                ),
              ),
      ],
    );
  }
}
