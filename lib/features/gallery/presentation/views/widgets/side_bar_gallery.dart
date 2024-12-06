import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_type.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/header_section.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/list_kitchen_types.dart';
import 'package:flutter/material.dart';

class SideBarGallery extends StatelessWidget {
  const SideBarGallery({
    super.key,
    required this.addType,
    required this.typesList,
    required this.changeIndex,
    required this.currIndex,
    required this.controller,
    required this.formKey,
    this.constraints,
    this.openCloseSideBar
  });
  final List<OnlyTypeModel> typesList;
  final void Function() addType;
  final void Function(int) changeIndex;
  final int currIndex;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final Widget?openCloseSideBar;
  final BoxConstraints?constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints,
      padding: const EdgeInsets.all(16),
      color: AppColors.veryLightGray,
      child: CustomScrollView(
        slivers: [
          HeaderSetionInGallery(
            openCloseSideBar: openCloseSideBar,
            formKey: formKey,
            controller: controller,
            addType: addType,
          ),
          ListOfKitchenTypes(
            currIndex: currIndex,
            onTap: (index) {
              changeIndex(index);
            },
            kitchenTypesList: typesList,
          )
        ],
      ),
    );
  }
}
