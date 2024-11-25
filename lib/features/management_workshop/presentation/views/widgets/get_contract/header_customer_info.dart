import 'package:pdf/widgets.dart' as pw;

class HeaderForCustomerInfo {
  const HeaderForCustomerInfo();

  pw.Widget build(pw.Font font, List<String> headerTexts) {
    return pw.Row(children: [
      pw.Expanded(
        flex: 3,
        child: pw.Text(
          headerTexts[0],
          maxLines: 2,
          style: constantPwTextStyle(font),
        ),
      ),
      pw.Expanded(child: pw.SizedBox()),
      pw.Expanded(
        flex: 2,
        child: pw.Text(
          headerTexts[1],
          style: constantPwTextStyle(font),
        ),
      ),
      pw.Expanded(child: pw.SizedBox()),
      pw.Expanded(
        flex: 2,
        child: pw.Text(
          headerTexts[2],
          style: constantPwTextStyle(font),
        ),
      ),
      pw.Expanded(child: pw.SizedBox()),
      pw.Expanded(
        flex: 2,
        child: pw.Text(
          headerTexts[3],
          style: constantPwTextStyle(font),
        ),
      ),
    ]);
  }

  pw.TextStyle constantPwTextStyle(pw.Font font) {
    return pw.TextStyle(font: font, fontSize: 10);
  }
}

