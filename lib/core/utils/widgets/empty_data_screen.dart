import 'package:al_hassan_warsha/core/utils/app_images/home_images.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:flutter/material.dart';

class EmptyDataScreen extends StatelessWidget {
  const EmptyDataScreen({super.key,this.emptyPushButtonText,this.emptyText,this.onTap});
  final String? emptyText;
  final String? emptyPushButtonText;
  final void Function() ?onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(
          scrollbars: false
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(HomeAssets.emptySceen,width: 500,fit: BoxFit.scaleDown,),
              Text(emptyText??"",style: AppFontStyles.extraBold50(context),),
              const SizedBox(height: 24,),
              CustomPushContainerButton(pushButtomText: emptyPushButtonText,borderRadius: 16,onTap: onTap,),
              const SizedBox(height: 24,),
            ],
          ),
        ),
      ),
    );
  }
}
