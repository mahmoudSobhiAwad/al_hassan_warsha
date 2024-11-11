import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/side_bar_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/side_bar_item.dart';
import 'package:flutter/cupertino.dart';


class SideBarManagement extends StatelessWidget {
  const SideBarManagement({super.key});

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
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: SideBarManagementItem(
                          model: sideBarManagementItemList[index],
                        ),
                      ),
                  childCount: sideBarManagementItemList.length))
        ],
      ),
    );
  }
}
