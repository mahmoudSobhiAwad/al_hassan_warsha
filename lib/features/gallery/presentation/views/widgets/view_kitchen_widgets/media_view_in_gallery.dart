import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_big_image_with_inner_shadow.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/small_kitchen_image.dart';
import 'package:flutter/material.dart';

class MediaInViewGallryItem extends StatelessWidget {
  const MediaInViewGallryItem({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 50,
                )),
            Flexible(
                child: CustomImageWithInnerShadow(
              enableShadow: false,
              aspectRatio: 5,
              fitType: BoxFit.fill,
            )),
            IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 50,
                )),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        SizedBox(
          height: height * 0.2,
          child: Center(
            child: ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return const SmallKitchenTypeImage(
                    widthOfImage: 0.085,
                    enableInner: false,
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 12,
                  );
                },
                itemCount: 10),
          ),
        ),
      ],
    );
  }
}
