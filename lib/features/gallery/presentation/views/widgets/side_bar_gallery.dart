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
    required this.currIndex
  });
  final List<OnlyTypeModel> typesList;
  final void Function(String) addType;
  final void Function(int)changeIndex;
  final int currIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.veryLightGray,
      child: CustomScrollView(
        slivers: [
          HeaderSetionInGallery(
            addType: (value){
            
              addType(value);
            },
          ),
          ListOfKitchenTypes(
            currIndex: currIndex,
            onTap: (index){
              changeIndex(index);
            },
            kitchenTypesList: typesList,
          ),
        ],
      ),
    );
  }
}
