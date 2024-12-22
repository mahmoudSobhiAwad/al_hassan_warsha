import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyContextMenu extends StatelessWidget {
  const MyContextMenu({required this.anchor, super.key});

  final Offset anchor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: anchor.dy,
          left: anchor.dx,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.veryLightGray,
            ),
            width: 200,
            child: Column(children: [
              CustomContextMenuItem(
                title: "حذف",
                iconData: Icons.delete,
                iconColor: AppColors.red,
                onTap: () {},
              ),
              const SizedBox(
                height: 12,
              ),
              CustomContextMenuItem(
                title: "اضافة",
                iconData: Icons.add,
                onTap: () {},
              ),
              const SizedBox(
                height: 12,
              ),
              CustomContextMenuItem(
                title: "تغيير لون الخلفية",
                iconData: Icons.colorize_rounded,
                onTap: () {},
              ),
              const SizedBox(
                height: 12,
              ),
              CustomContextMenuItem(
                title: "تغيير حجم الخط",
                iconData: Icons.format_size_rounded,
                onTap: () {},
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

class CustomContextMenuItem extends StatelessWidget {
  const CustomContextMenuItem({
    super.key,
    required this.iconData,
    required this.title,
    this.onTap,
    this.iconColor,
  });
  final String title;
  final IconData iconData;
  final void Function()? onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.veryLightGray,
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: AppFontStyles.bold16(context),
        ),
        hoverColor: AppColors.blackOpacity20,
        trailing: Icon(
          iconData,
          color: iconColor,
        ),
      ),
    );
  }
}
