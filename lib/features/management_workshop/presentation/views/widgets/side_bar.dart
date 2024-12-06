import 'package:al_hassan_warsha/core/utils/functions/conver_en_to_ar.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/side_bar_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/side_bar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideBarManagement extends StatelessWidget {
  const SideBarManagement(
      {super.key,
      required this.finishedLength,
      required this.nearLenght,
      required this.changeIndex,
      required this.currIndex,
      required this.neverLength,
      required this.totalLength});
  final int totalLength;
  final int finishedLength;
  final int neverLength;
  final int nearLenght;
  final int currIndex;
  final void Function(int) changeIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.veryLightGray,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
              child: CustomPushContainerButton(
            pushButtomText: "طلبات الشهر",
            iconBehind: CupertinoIcons.square_list,
            borderRadius: 20,
          )),
          const SliverToBoxAdapter(
              child: SizedBox(
            height: 24,
          )),
          SliverToBoxAdapter(
            child: Column(
              children: [
                ...List.generate(sideBarManagementItemList.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: InkWell(
                      onTap: () {
                        changeIndex(index);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: index == currIndex
                            ? BoxDecoration(
                                border: Border.all(
                                    width: 2, color: AppColors.brown),
                                borderRadius: BorderRadius.circular(12))
                            : null,
                        child: [
                          SideBarManagementItem(
                            model: SideBarManagementModel(
                                backgroundColor: AppColors.blueGray,
                                numberOfItem: convertToArabicNumbers(
                                    totalLength.toString()),
                                title: 'العدد الكلي'),
                          ),
                          SideBarManagementItem(
                            model: SideBarManagementModel(
                                backgroundColor: AppColors.green,
                                numberOfItem: convertToArabicNumbers(
                                    finishedLength.toString()),
                                title: 'تم التسليم',
                                icon: Icons.check),
                          ),
                          SideBarManagementItem(
                            model: SideBarManagementModel(
                                backgroundColor: AppColors.orange,
                                numberOfItem: convertToArabicNumbers(
                                    nearLenght.toString()),
                                title: 'اقترب تسليمه',
                                icon: Icons.hourglass_empty_rounded),
                          ),
                          SideBarManagementItem(
                              model: SideBarManagementModel(
                                  backgroundColor: AppColors.red,
                                  numberOfItem: convertToArabicNumbers(
                                      neverLength.toString()),
                                  title: 'لم يتم تسليمه',
                                  icon: Icons.close_rounded)),
                        ][index],
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
         
        ],
      ),
    );
  }
}
