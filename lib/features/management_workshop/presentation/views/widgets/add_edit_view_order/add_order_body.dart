import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/app_bar_with_linking.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/bill_details.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/customer_info.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/order_details_in_add.dart';
import 'package:flutter/material.dart';

class AddOrderBody extends StatelessWidget {
  const AddOrderBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  AppBarWithLinking(
                      items: ["إدارة الورشة", "اضافة عمل جديد"]),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomPushContainerButton(
                      pushButtomText: "استيراد من المعرض",
                      iconBehind: Icons.file_upload_outlined,
                      borderRadius: 16,
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: CustomerInfoInOrder(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 16,),
            ),
          
            SliverToBoxAdapter(
              child: OrderDetails(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 16,),
            ),
          
            SliverToBoxAdapter(
              child: BillDetails(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20,),
            ),
          
            SliverToBoxAdapter(
              child: Center(child: CustomPushContainerButton(pushButtomText: "اضافة الطلب",borderRadius: 16,)),
            ),
          ],
        ),
      ),
    );
  }
}
