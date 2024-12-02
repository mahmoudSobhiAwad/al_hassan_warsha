import 'dart:io';
import 'package:al_hassan_warsha/core/utils/app_images/home_images.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/get_contract/constant_style.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/get_contract/content_for_customer.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/get_contract/content_for_order.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/get_contract/header_customer_info.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/get_contract/pill_contract.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/get_contract/signature.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> getPdfContract(OrderModel orderModel) async {
  final pdf = pw.Document();

  final font = pw.Font.ttf(await rootBundle.load("font/Almarai-Regular.ttf"));

  const headerForCustomer = HeaderForCustomerInfo();
  const headerContent = ContentForCustomerInfo();
  const contentForOrderDetails = ContentForOrderInfo();
  const contractSignature = ContractSignature();
  final Uint8List watermarkImageData = await rootBundle
      .load(HomeAssets.waterMark)
      .then((data) => data.buffer.asUint8List());
  const pillInfo = PillInfo();
  pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Directionality(
          textDirection: pw.TextDirection.rtl,
          child: pw.Stack(children: [
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Center(
                    child: pw.Text(" الحسن  لصناعة الالوميتال  ",
                        style: constantPwTextStyle(font, size: 20)),
                  ),
                  pw.SizedBox(height: 15),
                  pw.Text("بيانات العميل ",
                      style: constantPwTextStyle(font, size: 12)),
                  pw.SizedBox(height: 10),
                  headerForCustomer.build(font, [
                    "اسم العميل ",
                    "رقم الهاتف",
                    "رقم هاتف احتياطي",
                    "عنوان المنزل"
                  ]),
                  pw.SizedBox(height: 15),
                  headerContent.build(font, model: orderModel.customerModel!),
                  pw.SizedBox(height: 15),
                  pw.Text("تفاصيل الطلب",
                      style: constantPwTextStyle(font, size: 12)),
                  pw.SizedBox(height: 15),
                  headerForCustomer.build(font, [
                    " اسم الطلب ",
                    " اللون المطلوب",
                    "نوع المطبخ",
                    "تاريخ الاستلام"
                  ]),
                  pw.SizedBox(height: 15),
                  contentForOrderDetails.build(font, orderModel: orderModel),
                  pw.SizedBox(height: 15),
                  pw.Text(" اضافات للطلب",
                      style: constantPwTextStyle(font, size: 12)),
                  pw.SizedBox(height: 15),
                  orderModel.extraOrdersList.isNotEmpty
                      ? pw.Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          alignment: pw.WrapAlignment.start,
                          children: [
                              ...List.generate(
                                  orderModel.extraOrdersList.length, (index) {
                                return pw.Container(
                                    padding: const pw.EdgeInsets.all(4),
                                    constraints: const pw.BoxConstraints(
                                      maxWidth: 400,
                                    ),
                                    decoration: pw.BoxDecoration(
                                      borderRadius: pw.BorderRadius.circular(4),
                                      border:
                                          pw.Border.all(color: PdfColors.grey),
                                    ),
                                    child: pw.Text(
                                        orderModel
                                            .extraOrdersList[index].extraName,
                                        style: constantPwTextStyle(font),
                                        maxLines: 2,
                                        overflow: pw.TextOverflow.clip));
                              })
                            ])
                      : pw.Text("لا يوجد اضافات ",
                          style: constantPwTextStyle(font, size: 12)),
                  pw.SizedBox(height: 15),
                  pw.Text("الفاتورة",
                      style: constantPwTextStyle(font, size: 15)),
                  pw.SizedBox(height: 15),
                  pillInfo.build(font, pillModel: orderModel.pillModel!),
                  pw.Spacer(),
                  contractSignature.build(font),
                ]),
            pw.Positioned(
              left: 100,
              top: 400,
              child: pw.Opacity(
                opacity: 0.3, // Adjust opacity for the watermark effect
                child: pw.Image(
                  pw.MemoryImage(watermarkImageData),
                  fit: pw.BoxFit.contain,
                  width: 300, // Adjust the size of the watermark image
                ),
              ),
            ),
          ]),
        );
      }));
  
  String? directoryPath = await FilePicker.platform.getDirectoryPath(dialogTitle:"استخراج نسخة عقد" );
  if (directoryPath != null) {
    final file = File("$directoryPath/${orderModel.customerModel?.customerName}.pdf");
    await file.writeAsBytes(await pdf.save());
  }
}


