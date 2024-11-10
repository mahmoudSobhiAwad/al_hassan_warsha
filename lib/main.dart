import 'package:al_hassan_warsha/core/utils/widgets/simple_bloc_observer.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/home.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  windowManager.setMinimumSize(const Size(300, 500));
  Bloc.observer = SimpleBlocObserver();
  runApp(const Alwarsha());
}

class Alwarsha extends StatelessWidget {
  const Alwarsha({super.key});
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconButtonTheme: const IconButtonThemeData(
            style: ButtonStyle(
                iconColor: WidgetStatePropertyAll<Color>(Colors.black))),
        useMaterial3: true,
      ),
      home: const Directionality(
          textDirection: TextDirection.rtl, child: HomeScreenView()),
    );
  }
}
