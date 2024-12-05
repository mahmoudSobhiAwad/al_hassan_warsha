import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/home/data/home_data.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/clipped_container.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/home_box_item.dart';
import 'package:flutter/material.dart';

class HomePhoneLayOut extends StatelessWidget {
  const HomePhoneLayOut(
      {super.key, required this.onChangePage, required this.onTap});
  final void Function() onTap;
  final void Function() onChangePage;

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
                  style: AppFontStyles.extraBold60(context),
                )),
            const SizedBox(
              height: 24,
            ),
            FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "اختيارك الأمثل لجميع أعمال الالوميتال",
                  style: AppFontStyles.extraBold35(context),
                )),
            const Expanded(child: SizedBox()),
            Expanded(
              flex: 5,
              child: PageView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.screenWidth*0.05),
                      child: HomeItem(
                        onTap: () {},
                        homeModel: homeModelList[index],
                         isPhone: true,
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
                  return index == 0
                      ? Container(
                          padding: const EdgeInsets.all(4),
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        )
                      : Container(
                          width: 25,
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                              color: AppColors.green, shape: BoxShape.circle),
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


extension MediaQueryValues on BuildContext {
  double get screenHeight => MediaQuery.sizeOf(this).height;
  double get screenWidth => MediaQuery.sizeOf(this).width;
}
