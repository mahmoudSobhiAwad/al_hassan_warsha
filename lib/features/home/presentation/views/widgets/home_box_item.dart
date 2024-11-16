import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/home/data/home_model.dart';
import 'package:flutter/material.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({super.key,required this.onTap, required this.homeModel});
  final HomeModel homeModel;
  final void Function()onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        hoverColor: Colors.white,
        highlightColor: Colors.white,
        focusColor: Colors.white,
        splashColor: Colors.white,
        child: Container(
          margin:const EdgeInsets.only(left: 35),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: AppColors.white,
            boxShadow: const [BoxShadow(
                  blurRadius: 4,
                  spreadRadius: 3,
                  color: AppColors.blackOpacity25,
                  offset: Offset(4, 25)),]
          ),
          child: Column(
            children: [
              Image.asset(
                homeModel.imagePath,
              ),
              const SizedBox(
                height: 12,
              ),
              FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(homeModel.title,
                      style: AppFontStyles.extraBold50(context))),
            ],
          ),
        ),
      ),
    );
  }
}
