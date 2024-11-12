import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/add_edit_view.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/one_order_item.dart';
import 'package:flutter/material.dart';

class ListOfOrder extends StatelessWidget {
  const ListOfOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 15,
      itemBuilder: (context, index) {
        return  Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: Row(
            children: [
              Expanded(child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddEditViewOrder()));
                },
                child: const OneOrderItem())),
              const SizedBox(
                width: 14,
              ),
              const Icon(Icons.more_vert)
            ],
          ),
        );
      },
    );
  }
}
