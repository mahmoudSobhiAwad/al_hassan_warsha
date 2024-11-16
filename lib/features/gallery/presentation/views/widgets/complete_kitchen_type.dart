import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/one_kitchen_list.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/show_more_kitchen_circle.dart';
import 'package:flutter/material.dart';

class CompleteKitchenType extends StatelessWidget {
  const CompleteKitchenType({super.key, this.isEmpty = false,required this.changeShowMore,});
  final bool isEmpty;
  final void Function(bool show)changeShowMore;
 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       // AddnewTypeWithKitchenName(model: model,),
        const SizedBox(
          height: 16,
        ),
        isEmpty
            ? Column(
                children: [
                  Text(
                    "لا يوجد اي عناصر من هذا النوع",
                    style: AppFontStyles.extraBold30(context),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomPushContainerButton(),
                ],
              )
            : SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.2,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ListOfOneKitchenType(),
                    const SizedBox(
                      width: 16,
                    ),
                    InkWell(
                        hoverColor: Colors.white,
                        highlightColor: Colors.white,
                        focusColor: Colors.white,
                        splashColor: Colors.white,
                        onTap: (){
                          changeShowMore(true);
                        },
                        child: const ShowMoreCirlcle())
                  ],
                ),
              ),
      ],
    );
  }
}
