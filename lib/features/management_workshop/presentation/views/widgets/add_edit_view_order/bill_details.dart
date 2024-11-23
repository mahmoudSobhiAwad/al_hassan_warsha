import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/pill_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/selected_payment_way.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BillDetails extends StatelessWidget {
  const BillDetails(
      {super.key,
      required this.pillModel,
      required this.onChangePayment,
      required this.changeStepsCounter});
  final PillModel pillModel;
  final void Function(OptionPaymentWay) onChangePayment;
  final void Function(bool) changeStepsCounter;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "الفاتورة",
          style: AppFontStyles.extraBold24(context),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: CustomColumnWithTextInAddNewType(
                    text: "المبلغ الكلي",
                    textLabel: "",
                    textInnerStyle: AppFontStyles.extraBold24(context),
                    textInputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9\u0660-\u0669\u06F0-\u06F9.]'),
                      ),
                    ],
                    onChanged: (value) {
                      pillModel.totalMoney = value ?? "";
                    },
                    textStyle: AppFontStyles.extraBold18(context),
                    enableBorder: true,
                    suffixIcon: Text(
                      "جنية",
                      style: AppFontStyles.extraBold18(context),
                    ),
                  )),
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                  flex: 2,
                  child: CustomColumnWithTextInAddNewType(
                    text: "المقدم ",
                    textLabel: "",
                    textInnerStyle: AppFontStyles.extraBold24(context),
                    textInputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9\u0660-\u0669\u06F0-\u06F9.]'),
                      ),
                    ],
                    onChanged: (value) {
                      pillModel.interior = value ?? "";
                    },
                    textStyle: AppFontStyles.extraBold18(context),
                    enableBorder: true,
                    suffixIcon: Text(
                      "جنية",
                      style: AppFontStyles.extraBold18(context),
                    ),
                  )),
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                  flex: 3,
                  child: SelectedPaymentWay(
                    onPressed: onChangePayment,
                    optionPaymentWay: pillModel.optionPaymentWay,
                  )),
              const Expanded(child: SizedBox()),
              switch (pillModel.optionPaymentWay) {
                OptionPaymentWay.onSteps => Expanded(
                    flex: 1,
                    child: CustomColumnWithTextInAddNewType(
                      onChanged: (value) {
                        pillModel.stepsCounter =
                            int.tryParse(value ?? "0") ?? 0;
                      },
                      text: "عدد الدفعات",
                      textAlign: TextAlign.center,
                      textLabel: "",
                      controller: TextEditingController(
                          text: pillModel.stepsCounter.toString()),
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^[0-9\u0660-\u0669\u06F0-\u06F9]+$'),
                        ),
                      ],
                      textStyle: AppFontStyles.extraBold18(context),
                      enableBorder: true,
                      suffixIcon: IconButton(
                          onPressed: () {
                            changeStepsCounter(true);
                          },
                          icon: const Icon(
                            Icons.add_circle_outlined,
                            size: 30,
                          )),
                      prefixIcon: IconButton(
                          onPressed: () {
                            changeStepsCounter(false);
                          },
                          icon: const Icon(
                            CupertinoIcons.minus_circle_fill,
                            color: Colors.black,
                            size: 30,
                          )),
                    )),
                OptionPaymentWay.atRecieve => const SizedBox()
              }
            ],
          ),
        ),
        
      ],
    );
  }
}
