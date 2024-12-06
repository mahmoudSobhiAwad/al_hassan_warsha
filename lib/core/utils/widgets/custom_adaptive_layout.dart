import 'package:flutter/material.dart';

class CustomAdaptiveLayout extends StatelessWidget {
  const CustomAdaptiveLayout({super.key,required this.desktopLayout,required this.mobileLayout,required this.tabletLayout});
  final WidgetBuilder mobileLayout,tabletLayout,desktopLayout;
  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(
          builder: (context,constraint) {
            if(constraint.maxWidth<600){
              return mobileLayout(context);
            }
            else if(constraint.maxWidth<1025){
              return tabletLayout(context);
            }
            else{
            return desktopLayout(context);
            }
          }
        );
  }
}