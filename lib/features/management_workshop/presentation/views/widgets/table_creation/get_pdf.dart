import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:al_hassan_warsha/features/management_workshop/data/models/table_model.dart';

Future<void> generateTablePdf({
  required int rows,
  required int columns,
  required List<List<CellInTableModel>> cellList,
  required List<double> columnWidths,
  required List<double> rowHeights,
}) async {
  final font = pw.Font.ttf(await rootBundle.load("font/Almarai-Regular.ttf"));

  LocalNotification notification =
      LocalNotification(title: "جدول", body: "إنشاء جدول جديد", actions: [
    LocalNotificationAction(text: "عرض"),
  ]);
  double totalWidth = 0;
  final pdf = pw.Document();
  for (int i = 0; i < columnWidths.length; i++) {
    totalWidth += columnWidths[i];
  }
  // Determine page format based on the total table width

  PdfPageFormat pageFormat;
  if (totalWidth <= PdfPageFormat.a4.availableWidth-5) {
    pageFormat = PdfPageFormat.a4;
  } else if (totalWidth <= PdfPageFormat.a3.availableWidth-5) {
    pageFormat = PdfPageFormat.a3;
  } else {
    pageFormat = PdfPageFormat(
      totalWidth + 40, // Add padding
      PdfPageFormat.a4.availableHeight,
    );
  }

  // Add pages using MultiPage for automatic pagination
  pdf.addPage(
    pw.MultiPage(
      pageFormat: pageFormat,
      build: (context) {
        return [
          pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Table(
              border: pw.TableBorder.all(),
              children: List.generate(rows, (rowIndex) {
                return pw.TableRow(
                  children: List.generate(columns, (colIndex) {
                    // Reverse the column order for RTL alignment
                    final reversedColIndex = columns - colIndex - 1;
                    final cell = cellList[rowIndex][reversedColIndex];
                    final cellColor = PdfColor.fromInt(
                        cell.getBackgroundColorHex ?? 0xffffffff);
                    final content = cell.getContentofCell ?? "";

                    return pw.Container(
                      width: columnWidths[reversedColIndex],
                      height: rowHeights[rowIndex],
                      padding: const pw.EdgeInsets.all(4),
                      color: cellColor,
                      child: pw.Text(
                        content,
                        style: pw.TextStyle(
                          fontSize: cell.getFontSize,
                          font: font,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    );
                  }),
                );
              }),
            ),
          ),
        ];
      },
    ),
  );

  // Save or Preview the PDF
  String? directoryPath =
      await FilePicker.platform.getDirectoryPath(dialogTitle: "جدول جديد");
  if (directoryPath != null) {
    final file = File("$directoryPath/جدول.pdf");
    await file.writeAsBytes(await pdf.save());
    await notification.show();
    notification.onClickAction = (actionIndex) async {
      await OpenFile.open(file.path);
    };
  }
}
