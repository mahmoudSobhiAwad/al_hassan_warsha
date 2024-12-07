import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/home/data/home_model.dart';
import 'package:flutter/material.dart';

class HomeItem extends StatelessWidget {
  const HomeItem(
      {super.key,
      required this.onTap,
      required this.homeModel,
      this.textStyle,
      });
  final HomeModel homeModel;
  final void Function() onTap;
  final TextStyle? textStyle;
 
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.white,
      highlightColor: Colors.white,
      focusColor: Colors.white,
      splashColor: Colors.white,
      child: Container(
         width: MediaQuery.sizeOf(context).width*0.3,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: AppColors.white,
            boxShadow: const [
              BoxShadow(
                  blurRadius: 4,
                  spreadRadius: 3,
                  color: AppColors.blackOpacity25,
                  offset: Offset(4, 25)),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Image.asset(
                homeModel.imagePath, 
              ),
            ),
            FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(homeModel.title,
                    style: textStyle ?? AppFontStyles.extraBoldNew38(context))),
          ],
        ),
      ),
    );
  }
}
