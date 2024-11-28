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
    required this.isTypingLoading,
    required this.controller,
    required this.formKey,
  });
  final List<OnlyTypeModel> typesList;
  final void Function(String) addType;
  final void Function(int) changeIndex;
  final int currIndex;
  final bool isTypingLoading;
  final TextEditingController controller;
  final GlobalKey<FormState>formKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.veryLightGray,
      child: CustomScrollView(
        slivers: [
          HeaderSetionInGallery(
            formKey: formKey,
            controller: controller,
            addType: (value) {
              addType(value);
            },
          ),
          isTypingLoading
              ? const SliverToBoxAdapter(child: CircularProgressIndicator())
              : ListOfKitchenTypes(
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
