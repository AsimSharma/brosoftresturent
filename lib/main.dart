import 'package:brosoftresturent/utils/routes.dart';
import 'package:brosoftresturent/view/message/message_screen.dart';
import 'package:brosoftresturent/view/order/order_screen.dart';
import 'package:brosoftresturent/view/profile/page/profile_screen.dart';

import 'package:brosoftresturent/view/table/screen/table_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'view/home/home.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // useMaterial3: true,
          ),
      home: const HomeScreen(),
      getPages: [
        GetPage(name: ResturantApp.home, page: () => const HomeScreen()),
        GetPage(name: ResturantApp.table, page: () => const TableScreen()),
        GetPage(name: ResturantApp.order, page: () => const OrderScreen()),
        GetPage(name: ResturantApp.message, page: () => const MessageScreen()),
        GetPage(name: ResturantApp.profile, page: () => const ProfileScreen()),
      ],
    );
  }
}
