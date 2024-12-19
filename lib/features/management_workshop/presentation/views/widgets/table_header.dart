import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_text_style_in_header.dart';
import 'package:flutter/cupertino.dart';

class TableHeader extends StatelessWidget {
  const TableHeader({super.key,this.enableAddress=true});
  final bool enableAddress;
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Expanded(child: CustomTextWithTheSameStyle(text: "الطلب",)),
        const Expanded(child: SizedBox()),
        const Expanded(flex: 1,child: CustomTextWithTheSameStyle(text: "وقت التسليم",)),
        const Expanded(child: SizedBox()),
        const Expanded(flex: 1,child: CustomTextWithTheSameStyle(text: "اسم العميل ",)),
        const Expanded(child: SizedBox()),
        const Expanded(flex: 1,child: CustomTextWithTheSameStyle(text: "هاتف العميل",)),
        const Expanded(child: SizedBox()),
        enableAddress?const Expanded(flex: 1,child: CustomTextWithTheSameStyle(text: "عنوان العميل",)):const SizedBox(),
        enableAddress?const Expanded(child: SizedBox()):const SizedBox(),
        const Expanded(flex: 1,child: CustomTextWithTheSameStyle(text: " حالة الطلب",)),
        const Expanded(child: SizedBox()),
        const Expanded(flex: 1,child: CustomTextWithTheSameStyle(text: "المبلغ المطلوب",)),
        
      ],
    );
  }
}

