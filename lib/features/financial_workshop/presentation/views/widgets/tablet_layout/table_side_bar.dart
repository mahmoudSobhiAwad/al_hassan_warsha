import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/side_bar_model.dart';
import 'package:flutter/material.dart';

class SideBarFinancialInTabletLayOut extends StatelessWidget {
  const SideBarFinancialInTabletLayOut(
      {super.key,
      required this.onPressed,
      required this.activeIndex,
      required this.isSideBarActive,
      required this.enableOrDisableSideBar});
  final void Function(int index) onPressed;
  final void Function(bool) enableOrDisableSideBar;
  final int activeIndex;
  final bool isSideBarActive;

  @override
  Widget build(BuildContext context) {
    return isSideBarActive
        ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: const BoxDecoration(
                color: AppColors.veryLightGray2,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Column(
              children: [
                ...List.generate(financialSideBarList.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Tooltip(
                      textStyle: AppFontStyles.bold12(context)
                          .copyWith(color: AppColors.white),
                      message: financialSideBarList[index].title,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(4)) // Rectangle shape
                                ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 20),
                            backgroundColor: index == activeIndex
                                ? AppColors.brown
                                : AppColors.veryLightGray2,
                          ),
                          onPressed: () {
                            onPressed(index);
                          },
                          child: Icon(
                            financialSideBarList[index].iconData,
                            color: index == activeIndex
                                ? AppColors.white
                                : AppColors.brown,
                          )),
                    ),
                  );
                }),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      enableOrDisableSideBar(false);
                    },
                    icon: const Icon(Icons.close)),
              ],
            ),
          )
        : Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(right: 10, bottom: 20),
              decoration: const BoxDecoration(
                color: AppColors.veryLightGray2,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                  onPressed: () {
                    enableOrDisableSideBar(true);
                  },
                  icon: const Icon(
                    Icons.expand_rounded,
                    size: 30,
                  )),
            ),
          );
  }
}
