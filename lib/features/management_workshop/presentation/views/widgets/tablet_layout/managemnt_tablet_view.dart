import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/management_body.dart';
import 'package:flutter/material.dart';

class ManagemntTabletView extends StatelessWidget {
  const ManagemntTabletView({super.key, required this.bloc});
  final ManagementBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ManagmentBody(
          bloc: bloc,
          enableAddress: false,
          enableSideBar: false,
          farzWidget: PopupMenuButton(
            icon:const Icon(Icons.filter_list_rounded,color: AppColors.blackOpacity50,size: 30,),
              onSelected: (index) {
                bloc.add(ChangeCategrizedListEvent(index: index));
              },
              initialValue: bloc.currIndex,
              color: AppColors.lightGray1,
              itemBuilder: (context) {
                return [
                  ...List.generate(
                      farzListInManagementOrders.length,
                      (index) => PopupMenuItem(
                            value: index,
                            child: Text(
                              farzListInManagementOrders[index],
                              style: AppFontStyles.extraBoldNew16(context),
                            ),
                          )),
                ];
              }),
        )),
      ],
    );
  }
}

List<String> farzListInManagementOrders = [
  "الكل",
  "تم تسلمية",
  "اقترب تسليمة",
  "لم يتم تسلمية",
];
