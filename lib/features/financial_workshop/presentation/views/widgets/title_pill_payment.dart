import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/filter_orders.dart';
import 'package:flutter/material.dart';

class TitleInBillPayment extends StatelessWidget {
  const TitleInBillPayment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(child: SizedBox()),
        Text(
          "دفع المرتبات",
          style: AppFontStyles.extraBoldNew26(context),
        ),
        const Expanded(flex: 13, child: SizedBox()),
        CustomContainerToPickHistory(
          child: Row(
            children: [
              Text(
                "فرز",
                style: AppFontStyles.extraBoldNew16(context),
              ),
              const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.filter_list_rounded,
                    size: 30,
                  ))
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}

