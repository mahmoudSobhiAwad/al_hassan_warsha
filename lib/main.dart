import 'package:al_hassan_warsha/features/home/presentation/views/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Alwarsha());
}

class Alwarsha extends StatelessWidget {
  const Alwarsha({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      useMaterial3: true,
      ),
      home:const Directionality(
        textDirection: TextDirection.rtl,
        child: HomeScreenView()),
    );
  }
}
