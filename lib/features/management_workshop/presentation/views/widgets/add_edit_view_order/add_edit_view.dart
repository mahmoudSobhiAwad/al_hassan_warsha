import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_app_bar.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/add_order_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddEditViewOrder extends StatelessWidget {
  const AddEditViewOrder({super.key});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: Column(
            children: [
              CustomAppBar(changeIndex: (index) {}, currIndex: 1),
              const SizedBox(
                height: 12,
              ),
              const AddOrderBody(),
            ],
          ),
        ),
      ),
    );
  }
}





