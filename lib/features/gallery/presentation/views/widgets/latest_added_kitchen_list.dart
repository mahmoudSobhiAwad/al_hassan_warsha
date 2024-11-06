import 'dart:async';

import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_inner_shadow.dart';
import 'package:flutter/material.dart';

class AutoScrollingPageView extends StatefulWidget {
  const AutoScrollingPageView({super.key});

  @override
  AutoScrollingPageViewState createState() => AutoScrollingPageViewState();
}

class AutoScrollingPageViewState extends State<AutoScrollingPageView> {
  // final PageController _pageController = PageController();
  // Timer? _timer;
  // int _currentPage = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   _startAutoScroll();
  // }

  // void _startAutoScroll() {
  //   _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
  //     if (_pageController.hasClients) {
  //       _currentPage++;
  //       if (_currentPage >= 5) { // Assuming there are 5 pages
  //         _currentPage = 0;
  //       }
  //       _pageController.animateToPage(
  //         _currentPage,
  //         duration: const Duration(milliseconds: 500),
  //         curve: Curves.easeInOut,
  //       );
  //     }
  //   });
  // }

  // @override
  // void dispose() {
  //   _timer?.cancel();
  //   _pageController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return  AspectRatio(
            aspectRatio: 1225/250,
            child: PageView.builder(
             // controller: _pageController,
              itemCount: 4,
              itemBuilder: (context,index){
              return const CustomImageWithInnerShadow();
            }),
          );
  }
}

class CustomImageWithInnerShadow extends StatelessWidget {
  const CustomImageWithInnerShadow({
    super.key,
    this.aspectRatio,
    this.aspectRatioInner,
  });
  final double? aspectRatio;
  final double? aspectRatioInner;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AspectRatio(
          aspectRatio:aspectRatio?? 1225/250,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.network("https://www.muretti.com/wp-content/uploads/2023/08/Metal-Kitchen-Cabinets.jpeg",fit: BoxFit.fitWidth,),
            ),
           ),
         CustomInnerShadowInLastKitchen(aspectRatio: aspectRatioInner,),
      ],
    ),
    );
  }
}
