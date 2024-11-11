import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_text_style_in_header.dart';
import 'package:flutter/cupertino.dart';

class TableHeader extends StatelessWidget {
  const TableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Row(
        children: [
          Expanded(child: CustomTextWithTheSameStyle(text: "الطلب",)),
          Expanded(child: SizedBox()),
          Expanded(flex: 2,child: CustomTextWithTheSameStyle(text: "تفاصيل الطلب",)),
          Expanded(child: SizedBox()),
          Expanded(flex: 1,child: CustomTextWithTheSameStyle(text: "وقت التسليم",)),
          Expanded(child: SizedBox()),
          Expanded(flex: 1,child: CustomTextWithTheSameStyle(text: "اسم العميل ",)),
          Expanded(child: SizedBox()),
          Expanded(flex: 1,child: CustomTextWithTheSameStyle(text: "هاتف العميل",)),
          Expanded(child: SizedBox()),
          Expanded(flex: 1,child: CustomTextWithTheSameStyle(text: "عنوان العميل",)),
          Expanded(child: SizedBox()),
          Expanded(flex: 1,child: CustomTextWithTheSameStyle(text: "المبلغ المطلوب",)),
          
        ],
      ),
    );
  }
}

