import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/get_contract/constant_style.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ContentForOrderInfo {
  const ContentForOrderInfo();
  pw.Widget build(pw.Font font, {required OrderModel orderModel}) {
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
                orderModel.orderName,
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
                orderModel.colorModel?.colorName ?? "لا يوجد",
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
                orderModel.kitchenType ?? "لا يوجد",
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
                DateFormat('d MMMM y', 'ar')
                    .format(orderModel.recieveTime ?? DateTime.now()),
                style: constantPwTextStyle(font))),
      ),
    ]);
  }
}

