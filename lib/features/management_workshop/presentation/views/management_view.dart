import 'package:al_hassan_warsha/core/utils/widgets/empty_data_screen.dart';
import 'package:flutter/material.dart';

class ManagementView extends StatelessWidget {
   const ManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return const  EmptyDataScreen(emptyText: "لا يوجد اي طلبات حاليا لدي الورشة",);
  }
}