import 'package:flutter/material.dart';

class CustomClipPath extends CustomClipper<Path>{
  @override
  getClip(Size size) {
    double w=size.width;
    double h=size.height;
    final path=Path();
    path.lineTo(0, h);
    path.lineTo(w, h);
    path.lineTo(w, 0);
    path.quadraticBezierTo(w*0.5, h-150, 0 , 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) =>false;
}
