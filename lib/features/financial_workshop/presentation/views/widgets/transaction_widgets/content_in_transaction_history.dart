import 'package:al_hassan_warsha/core/utils/functions/conver_en_to_ar.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/transaction_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/action_types_in_dialog.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/alert_to_check_db.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_text_style_in_header.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContentInTransactionHistory extends StatelessWidget {
  const ContentInTransactionHistory(
      {super.key,
      required this.model,
      this.deleteTrans,
      this.isTabletLayout = false});
  final TransactionModel model;
  final bool isTabletLayout;
  final void Function(String id)? deleteTrans;
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
                    flex: 2,
                    child: CustomTextWithTheSameStyle(
                        text: switch (model.allTransactionTypes) {
                      AllTransactionTypes.interior => "مقدم",
                      AllTransactionTypes.stepDown => "تنزيل قسط",
                      AllTransactionTypes.pills => "فواتير",
                      AllTransactionTypes.salaries => "مرتبات",
                      AllTransactionTypes.buys => "مشتريات",
                      AllTransactionTypes.other => model.transactionName,
                    })),
                const Expanded(child: SizedBox()),
                Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextWithTheSameStyle(
                          textStyle: AppFontStyles.extraBoldNew16(context)
                              .copyWith(letterSpacing: 3),
                          text:
                              "${convertToArabicNumbers(model.transactionAmount)} ",
                        ),
                        Text(
                          "جنية",
                          style:  AppFontStyles.extraBold14(context),
                        ),
                      ],
                    )),
                const Expanded(child: SizedBox()),
                Expanded(
                    flex: 4,
                    child: CustomTextWithTheSameStyle(
                      letterSpacing: 3,
                      text: DateFormat('d MMMM y - h:mm a', 'ar')
                          .format(model.transactionTime ?? DateTime.now()),
                    )),
                const Expanded(child: SizedBox()),
                Expanded(
                    flex: 2,
                    child: Center(
                      child: CustomTextWithTheSameStyle(
                        text:
                            model.transactionMethod == TransactionMethod.caching
                                ? "كاش"
                                : "تحويل بنكي",
                      ),
                    )),
                const Expanded(child: SizedBox()),
                Expanded(
                    flex: 2,
                    child: Center(
                      child: CustomTextWithTheSameStyle(
                        text: model.transactionType == TransactionType.buy
                            ? "دفع"
                            : "استلام",
                      ),
                    )),
              ],
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
        deleteTrans != null
            ? Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: CustomAlert(
                              enableIcon: false,
                              actionButtonsInstead:
                                  DialogAddNewTypeActionButton(
                                onPressed_2: () {
                                  Navigator.pop(context);
                                },
                                text_1: "تأكيد ",
                                text_2: "الغاء",
                                onPressed_1: () {
                                  deleteTrans!(model.transactionId!);
                                  Navigator.pop(context);
                                },
                              ),
                              title:
                                  "هل تريد حذف التحويل نهائي سيتم حذفة من الحسابات ايضا !!",
                            ),
                          );
                        });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!isTabletLayout)
                        Flexible(
                          child: Text(
                            "حذف التحويل",
                            style:
                                AppFontStyles.extraBoldNew16(context).copyWith(
                              color: AppColors.red,
                            ),
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
                  ),
                ))
            : const SizedBox(),
      ],
    );
  }
}
