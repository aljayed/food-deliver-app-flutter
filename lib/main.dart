import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_project/pages/home_screens.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ThemeData().colorScheme.copyWith(
      //     secondary: Colors.deepOrangeAccent,
      //     primary: Colors.deepOrangeAccent,
      //   ),
      // ),
      theme: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(
          secondary: Colors.deepOrangeAccent,
          primary: Colors.deepOrangeAccent,
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}