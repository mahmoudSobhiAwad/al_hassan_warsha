import 'package:al_hassan_warsha/core/utils/app_images/home_images.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:flutter/material.dart';

class EmptyDataScreen extends StatelessWidget {
  const EmptyDataScreen(
      {super.key,
      this.emptyPushButtonText,
      this.emptyText,
      this.onTap,
      this.flex,
      this.enablePush = true});
  final String? emptyText;
  final String? emptyPushButtonText;
  final void Function()? onTap;
  final bool enablePush;
  final int? flex;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex??1,
      child: Scrollbar(
         radius:const Radius.circular(5),
        thickness: 15,
        thumbVisibility: true,
        trackVisibility: true,
        scrollbarOrientation: ScrollbarOrientation.right,
        child: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(scrollbars: false),
          child: SingleChildScrollView(
            primary: true,
            child: Column(
              children: [
                Image.asset(
                  HomeAssets.emptySceen,
                  width: 500,
                  fit: BoxFit.scaleDown,
                ),
                Text(
                  emptyText ?? "",
                  style: AppFontStyles.extraBold50(context),
                ),
                SizedBox(
                  height: enablePush ? 24 : 0,
                ),
                 enablePush?CustomPushContainerButton(
                  pushButtomText: emptyPushButtonText,
                  borderRadius: 16,
                  onTap: onTap,
                ):const SizedBox(),
                SizedBox(
                  height: enablePush ? 24 : 0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
