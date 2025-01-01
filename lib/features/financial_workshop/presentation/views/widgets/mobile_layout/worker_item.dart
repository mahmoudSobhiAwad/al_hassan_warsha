import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/worker_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/mobile_layout/order_item_in_mobile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WorkersItemInMobileLayout extends StatelessWidget {
  const WorkersItemInMobileLayout({
    super.key,
    required this.workerModel,
  });

  final WorkerModel workerModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: DetailsInOrderItemMobile(
              color: AppColors.black,
              title: workerModel.workerName,
              iconData: Icons.person),
        ),
        Flexible(
          child: DetailsInOrderItemMobile(
              textStyle: AppFontStyles.extraBoldNew16(context)
                  .copyWith(letterSpacing: 2),
              title: "${workerModel.salaryAmount} جنية",
              color: AppColors.black,
              iconData: FontAwesomeIcons.moneyBill),
        ),
        Flexible(
          child: DetailsInOrderItemMobile(
              color: AppColors.black,
              title: workerModel.workerPhone ?? "غير محدد",
              iconData: Icons.phone_android_rounded),
        ),
        Flexible(
          child: DetailsInOrderItemMobile(
              color: AppColors.black,
              title: switch (workerModel.salaryType) {
                SalaryType.daily => "يومي",
                SalaryType.weekly => "أسبوعي",
                SalaryType.monthly => "شهري",
              },
              iconData: Icons.timer),
        ),
      ],
    );
  }
}
