import 'package:al_hassan_warsha/core/utils/widgets/simple_bloc_observer.dart';
import 'package:al_hassan_warsha/features/home/presentation/manager/bloc/home_basic_bloc.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  sqfliteFfiInit();
  windowManager.setMinimumSize(const Size(300, 500));
  Bloc.observer = SimpleBlocObserver();
  runApp(const Alwarsha());
}

class Alwarsha extends StatelessWidget {
  const Alwarsha({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBasicBloc()..add(CheckDbExistEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          iconTheme: const IconThemeData(color: Colors.black),
          iconButtonTheme: const IconButtonThemeData(
              style: ButtonStyle(
                  iconColor: WidgetStatePropertyAll<Color>(Colors.black))),
          useMaterial3: true,
        ),
        home: const Directionality(
            textDirection: TextDirection.rtl, child: HomeScreenView()),
      ),
    );
  }
}
