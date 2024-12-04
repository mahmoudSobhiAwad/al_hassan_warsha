import 'package:pdf/widgets.dart' as pw;

pw.TextStyle constantPwTextStyle(pw.Font font, {double? size,double ?letterSpacing}) => pw.TextStyle(
      fontSize: size ?? 10,
      font: font,
      letterSpacing: letterSpacing,
    );

