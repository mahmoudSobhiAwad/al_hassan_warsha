import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/action_types_in_dialog.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_box_shadow.dart';
import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget {
  const CustomAlert(
      {super.key,
      this.onPressed_2,
      this.actionButtonsInstead,
      this.onPressed_1,
      this.enableIcon = true,
      this.pickPathesWidget,
      this.iconData,
      this.titleSize,
      this.iconSize,
      this.title});
  final void Function()? onPressed_2;
  final void Function()? onPressed_1;
  final String? title;
  final double?titleSize;
  final double?iconSize;
  final bool enableIcon;
  final Widget? actionButtonsInstead;
  final Widget? pickPathesWidget;
  final IconData? iconData;
  

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.5,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              customLowBoxShadow(),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title ??
                  "لا يوجد اي قاعدة بيانات حالية لديك هل لديك بيانات تود استراجعها ؟",
              style: AppFontStyles.extraBold40(context).copyWith(fontSize: titleSize),
              textAlign: TextAlign.center,
            ),
            enableIcon
                ? IconButton(
                    onPressed: null,
                    icon: Icon(
                      iconData ?? Icons.warning,
                      color: AppColors.orange,
                      size: iconSize?? 70,
                    ),
                  )
                : const SizedBox(
                    height: 20,
                  ),
            pickPathesWidget ?? const SizedBox(),
            pickPathesWidget == null
                ? const SizedBox()
                : const SizedBox(
                    height: 20,
                  ),
            actionButtonsInstead ??
                DialogAddNewTypeActionButton(
                    color_1: AppColors.green,
                    color_2: AppColors.blue,
                    text_1: "استرجاع",
                    text_2: "إنشاء جديد",
                    onPressed_2: onPressed_2,
                    onPressed_1: () {
                      onPressed_1 != null
                          ? onPressed_1!()
                          : Navigator.pop(context);
                    }),
          ],
        ),
      ),
    );
  }
}

class PickPathForDb extends StatelessWidget {
  const PickPathForDb({
    super.key,
    required this.pickTempPath,
    this.tempPath,
    this.isRestoring = false,
  });
  final String? tempPath;
  final void Function() pickTempPath;
  final bool isRestoring;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isRestoring
            ? const SizedBox()
            : Row(
                children: [
                  const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.folder,
                        color: AppColors.lightGray1,
                      )),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    "البيانات الاساسية - تم تحديد المكان ",
                    style: AppFontStyles.extraBold20(context),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.check_rounded,
                        color: AppColors.green,
                      )),
                  const SizedBox(
                    width: 12,
                  ),
                ],
              ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            tempPath == null
                ? const CircularProgressIndicator(
                    strokeWidth: 2,
                  )
                : const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.check_rounded,
                      color: AppColors.green,
                    )),
            const SizedBox(
              width: 12,
            ),
            Text(
              "البيانات الاحتياطية",
              style: AppFontStyles.extraBold20(context),
            ),
            const SizedBox(
              width: 6,
            ),
            Text(
              tempPath ??
                  (isRestoring
                      ? "----- حدد المكان المراد النقل منه "
                      : "----- حدد المكان المراد التخزين به !"),
              style: AppFontStyles.extraBold20(context)
                  .copyWith(decoration: TextDecoration.underline),
            ),
            const SizedBox(
              width: 12,
            ),
            IconButton(
                onPressed: pickTempPath,
                icon: const Icon(
                  Icons.folder,
                  color: AppColors.lightGray1,
                )),
          ],
        ),
      ],
    );
  }
}
