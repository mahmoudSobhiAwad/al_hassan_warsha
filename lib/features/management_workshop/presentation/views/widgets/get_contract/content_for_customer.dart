import 'package:al_hassan_warsha/features/management_workshop/data/models/customer_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/get_contract/constant_style.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ContentForCustomerInfo {
  const ContentForCustomerInfo();
  pw.Widget build(pw.Font font, {required CustomerModel model}) {
    return pw.Row(children: [
      pw.Expanded(
        flex: 3,
        child: pw.Container(
            padding: const pw.EdgeInsets.all(4),
            decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey, width: 1),
                borderRadius: pw.BorderRadius.circular(4)),
            child: pw.Text(
                maxLines: 2,
                "${model.customerName}",
                style: constantPwTextStyle(font))),
      ),
      pw.Expanded(child: pw.SizedBox()),
      pw.Expanded(
        flex: 2,
        child: pw.Container(
            padding: const pw.EdgeInsets.all(4),
            decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey, width: 1),
                borderRadius: pw.BorderRadius.circular(4)),
            child: pw.Text(
                maxLines: 2,
                model.phone ?? "لا يوجد",
                style: constantPwTextStyle(font))),
      ),
      pw.Expanded(child: pw.SizedBox()),
      pw.Expanded(
        flex: 2,
        child: pw.Container(
            padding: const pw.EdgeInsets.all(4),
            decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey, width: 1),
                borderRadius: pw.BorderRadius.circular(4)),
            child: pw.Text(
                maxLines: 2,
                model.secondPhone ?? "لا يوجد",
                style: constantPwTextStyle(font))),
      ),
      pw.Expanded(child: pw.SizedBox()),
      pw.Expanded(
        flex: 2,
        child: pw.Container(
            padding: const pw.EdgeInsets.all(4),
            decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey, width: 1),
                borderRadius: pw.BorderRadius.circular(4)),
            child: pw.Text(
                maxLines: 2,
                model.homeAddress ?? "لا يوجد",
                style: constantPwTextStyle(font))),
      ),
    ]);
  }
}


