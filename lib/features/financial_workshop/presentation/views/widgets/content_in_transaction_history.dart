import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/transaction_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_text_style_in_header.dart';
import 'package:flutter/material.dart';

class ContentInTransactionHistory extends StatelessWidget {
  const ContentInTransactionHistory({super.key, required this.model});
  final TransactionModel model;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 14,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 7.5,
                    color: AppColors.blackOpacity20)
              ],
              borderRadius: BorderRadius.circular(12),
              color: AppColors.white,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    flex: 4,
                    child: CustomTextWithTheSameStyle(
                        textStyle: AppFontStyles.extraBold18(context),
                        text: model.transactionName)),
                const Expanded(child: SizedBox()),
                Expanded(
                    flex: 2,
                    child: CustomTextWithTheSameStyle(
                      textStyle: AppFontStyles.extraBold18(context),
                      text: "${model.transactionAmount} جنية",
                    )),
                const Expanded(child: SizedBox()),
                Expanded(
                    flex: 2,
                    child: CustomTextWithTheSameStyle(
                      textStyle: AppFontStyles.extraBold18(context),
                      text: "${model.transactionTime}",
                    )),
                const Expanded(child: SizedBox()),
                Expanded(
                    flex: 2,
                    child: Center(
                      child: CustomTextWithTheSameStyle(
                        textStyle: AppFontStyles.extraBold18(context),
                        text: model.transactionMethod == TransactionMethod.caching
                            ? "كاش"
                            : "تحويل بنكي",
                      ),
                    )),
                const Expanded(child: SizedBox()),
                Expanded(
                    flex: 2,
                    child: Center(
                      child: CustomTextWithTheSameStyle(
                        textStyle: AppFontStyles.extraBold18(context),
                        text: model.transactionType == TransactionType.buy
                            ? "شراء"
                            : "استلام",
                      ),
                    )),
                
              ],
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
        Expanded(
            flex: 2,
            child: Row(
              children: [
                Text(
                  "حذف التحويل",
                  style: AppFontStyles.extraBold18(context).copyWith(
                    color: AppColors.red,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.delete,
                      color: AppColors.red,
                    )),
              ],
            )),
            
      ],
    );
  }
}
