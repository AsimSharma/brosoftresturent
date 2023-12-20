import 'package:brosoftresturent/utils/routes.dart';
import 'package:brosoftresturent/view/message/message_screen.dart';
import 'package:brosoftresturent/view/order/order_screen.dart';
import 'package:brosoftresturent/view/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/home/home.dart';

void main() {
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      getPages: [
        GetPage(name: ResturantApp.home, page: () => const HomeScreen()),
        GetPage(name: ResturantApp.table, page: () => const Tablexyx()),
        GetPage(name: ResturantApp.order, page: () => const OrderScreen()),
        GetPage(name: ResturantApp.message, page: () => const MessageScreen()),
        GetPage(name: ResturantApp.profile, page: () => const ProfileScreen()),
      ],
    );
  }
}

class Tablexyx extends StatelessWidget {
  const Tablexyx({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Demo Table "),
      ),
    );
  }
}
