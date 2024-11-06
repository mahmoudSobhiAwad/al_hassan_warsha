import 'package:al_hassan_warsha/core/utils/widgets/custom_ingradient.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/custom_clipper.dart';
import 'package:flutter/material.dart';

class ClippedContainer extends StatelessWidget {
  const ClippedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: CustomClipPath(),
                child: Container(
                  decoration:  BoxDecoration(
                    gradient: customLinearGradient(),
                  ),
                  height: MediaQuery.sizeOf(context).height*0.33,
                  width: double.infinity,
                ),
              ),
            );
  }

}
