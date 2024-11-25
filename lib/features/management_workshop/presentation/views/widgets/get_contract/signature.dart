import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/get_contract/constant_style.dart';
import 'package:pdf/widgets.dart' as pw;

class ContractSignature {
  const ContractSignature();
  pw.Widget build(pw.Font font) {
    return pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Text("توقيع الادارة",
                style: constantPwTextStyle(font, size: 15)),
            pw.SizedBox(height: 15),
            pw.Text("-------------------", style: constantPwTextStyle(font)),
          ]),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Text("توقيع العميل", style: constantPwTextStyle(font, size: 15)),
            pw.SizedBox(height: 15),
            pw.Text("-------------------", style: constantPwTextStyle(font)),
          ]),
        ]);
  }
}
