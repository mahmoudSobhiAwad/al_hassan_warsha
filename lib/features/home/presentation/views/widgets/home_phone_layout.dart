import 'package:al_hassan_warsha/core/utils/functions/extentions.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/home/data/home_data.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/clipped_container.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/home_box_item.dart';
import 'package:flutter/material.dart';

class HomePhoneLayOut extends StatelessWidget {
  const HomePhoneLayOut(
      {super.key,
      required this.onChangePage,
      required this.onTap,
      required this.isLoading,
      required this.pageIndex});
  final void Function(int) onTap;
  final void Function(int) onChangePage;
  final bool isLoading;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ClippedContainer(),
        Column(
          children: [
            FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "الحسن ",
                  style: AppFontStyles.extraBoldNew50(context),
                )),
            const SizedBox(
              height: 24,
            ),
            FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "اختيارك الأمثل لجميع أعمال الالوميتال",
                  style: AppFontStyles.extraBoldNew26(context),
                )),
            const Expanded(child: SizedBox()),
            Expanded(
              flex: 5,
              child: isLoading
                  ? Container(
                      decoration: BoxDecoration(
                          color: AppColors.lightGray1,
                          borderRadius: BorderRadius.circular(12),
                          backgroundBlendMode: BlendMode.dstIn),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : PageView.builder(
                      onPageChanged: (index) {
                        onChangePage(index);
                      },
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.screenWidth * 0.05),
                          child: HomeItem(
                            onTap: () {
                              onTap(index);
                            },
                            homeModel: homeModelList[index],
                          ),
                        );
                      }),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(3, (index) {
                  return index == pageIndex
                      ? Container(
                          padding: const EdgeInsets.all(4),
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        )
                      : Container(
                          width: 25,
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                              color: AppColors.lightGray1,
                              shape: BoxShape.circle),
                        );
                })
              ],
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }
}

