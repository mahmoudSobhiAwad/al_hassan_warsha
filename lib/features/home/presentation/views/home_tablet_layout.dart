import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/home/data/home_data.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/clipped_container.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/home_box_item.dart';
import 'package:flutter/material.dart';

class HomeScreenTabletLayout extends StatelessWidget {
  const HomeScreenTabletLayout(
      {super.key, required this.onTap, required this.isLoading});
  final void Function(int) onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ClippedContainer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "الحسن ",
                  style: AppFontStyles.extraBoldNew40(context),
                )),
            const SizedBox(
              height: 24,
            ),
            FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "اختيارك الأمثل لجميع أعمال الالوميتال",
                  style: AppFontStyles.extraBoldNew30(context),
                )),
            isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: Column(
                      children: [
                        const Expanded(child: SizedBox()),
                        Expanded(
                          flex: 5,
                          child: GridView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              itemCount: 3,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 20,
                                      childAspectRatio: 1.25,
                                      mainAxisSpacing: 15),
                              itemBuilder: (context, index) {
                                return HomeItem(
                                  textStyle: AppFontStyles.extraBoldNew30(context),
                                  onTap: () {
                                    onTap(index);
                                  },
                                  homeModel: homeModelList[index],
                                );
                              }),
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}
