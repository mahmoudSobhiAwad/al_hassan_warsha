import 'dart:async';

import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_big_image_with_inner_shadow.dart';
import 'package:flutter/material.dart';

class AutoScrollingPageView extends StatefulWidget {
  const AutoScrollingPageView({super.key,required this.kitchenModelList});
  final List<KitchenModel>kitchenModelList;
  @override
  AutoScrollingPageViewState createState() => AutoScrollingPageViewState();
}

class AutoScrollingPageViewState extends State<AutoScrollingPageView> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        _currentPage++;
     
        if (_currentPage >= widget.kitchenModelList.length) { 
          _currentPage = 0;
        }
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  AspectRatio(
            aspectRatio: 1225/250,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.kitchenModelList.length,
              itemBuilder: (context,index){
              return CustomImageWithInnerShadow(model: widget.kitchenModelList[index],);
            }),
          );
  }
}

