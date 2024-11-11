import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/one_order_item.dart';
import 'package:flutter/material.dart';

class ListOfOrder extends StatelessWidget {
  const ListOfOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList.builder(
          
          itemCount: 15,
          itemBuilder: (context,index){
          return const Padding(
            padding: EdgeInsets.only(bottom: 18),
            child: Row(
                      children: [
                        Expanded(child: OneOrderItem()),
                        SizedBox(
                          width: 14,
                        ),
                        Icon(Icons.more_vert)
                      ],
                    ),
          );
        },)
      ],
    );
  }
}
