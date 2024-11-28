import 'package:al_hassan_warsha/core/utils/functions/conver_en_to_ar.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/pill_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/get_contract/constant_style.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PillInfo {
  const PillInfo();
  pw.Widget build(pw.Font font, {required PillModel pillModel}) {
    return pw.Row(children: [
      pw.Expanded(
        flex: 2,
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("المبلغ الكلي",
                  style: constantPwTextStyle(font, size: 12)),
              pw.SizedBox(height: 5),
              pw.Container(
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    borderRadius: pw.BorderRadius.circular(4),
                    border: pw.Border.all(color: PdfColors.grey),
                  ),
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(pillModel.totalMoney,
                            style: constantPwTextStyle(font, size: 14)),
                        pw.Text("جنية", style: constantPwTextStyle(font)),
                      ])),
            ]),
      ),
      pw.Expanded(child: pw.SizedBox()),
      pw.Expanded(
        flex: 2,
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(" المقدم ", style: constantPwTextStyle(font, size: 12)),
              pw.SizedBox(height: 5),
              pw.Container(
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    borderRadius: pw.BorderRadius.circular(4),
                    border: pw.Border.all(color: PdfColors.grey),
                  ),
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(pillModel.interior,
                            style: constantPwTextStyle(font, size: 14)),
                        pw.Text("جنية", style: constantPwTextStyle(font)),
                      ])),
            ]),
      ),
      pw.Expanded(child: pw.SizedBox()),
      pw.Expanded(
        flex: 2,
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(" المبلغ المتبقي ",
                  style: constantPwTextStyle(font, size: 12)),
              pw.SizedBox(height: 5),
              pw.Container(
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    borderRadius: pw.BorderRadius.circular(4),
                    border: pw.Border.all(color: PdfColors.grey),
                  ),
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(convertToArabicNumbers(pillModel.remian),
                            style: constantPwTextStyle(font, size: 14)),
                        pw.Text("جنية", style: constantPwTextStyle(font)),
                      ])),
            ]),
      ),
      pw.Expanded(child: pw.SizedBox()),
      pillModel.optionPaymentWay == OptionPaymentWay.atRecieve
          ? pw.Expanded(
              flex: 2,
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(" عدد الدفعات", style: constantPwTextStyle(font)),
                    pw.SizedBox(height: 10),
                    pw.Text("الدفع عند الاستلام",
                        style: constantPwTextStyle(font)),
                  ]),
            )
          : pw.Expanded(
              flex: 2,
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("عدد الدفعات ", style: constantPwTextStyle(font)),
                    pw.SizedBox(width: 15),
                    pw.Container(
                        padding: const pw.EdgeInsets.all(7),
                        decoration: pw.BoxDecoration(
                            border:
                                pw.Border.all(color: PdfColors.grey, width: 1),
                            borderRadius: pw.BorderRadius.circular(4)),
                        child: pw.Text(pillModel.stepsCounter.toString(),
                            style: constantPwTextStyle(font))),
                  ]),
            )
    ]);
  }
}
