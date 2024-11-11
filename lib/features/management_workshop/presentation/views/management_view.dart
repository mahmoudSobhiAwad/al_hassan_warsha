import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/filter_orders.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/full_header.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/list_of_orders.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/search_bar.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/side_bar.dart';
import 'package:flutter/material.dart';

class ManagementView extends StatelessWidget {
  const ManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Row(
        children: [
          Expanded(child: SideBarManagement()),
          Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SearchBarInManagment(),
                    SizedBox(
                      height: 24,
                    ),
                    FilterOrdersWithMonthYear(),
                    FullTableHeader(),
                    Expanded(flex: 5,child: ListOfOrder()),
                    SizedBox(
                      height: 16,
                    ),
                    CustomPushContainerButton(pushButtomText: "طلب جديد",padding: EdgeInsets.symmetric(horizontal: 24,vertical: 10),borderRadius: 12,),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

