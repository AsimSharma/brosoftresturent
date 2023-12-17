import 'package:brosoftresturent/utils/app_style.dart';
import 'package:brosoftresturent/view/message/message_screen.dart';
import 'package:brosoftresturent/view/order/order_screen.dart';
import 'package:brosoftresturent/view/profile/profile_screen.dart';
import 'package:brosoftresturent/view/table/table_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController();
  int _pageIndex = 0;

  _onPageChanged(int pageIndex) {
    setState(() {
      _pageIndex = pageIndex;
    });
  }

  _onTap(int page) {
    setState(() {
      _pageController.jumpToPage(page);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: _onPageChanged,
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        children: const [
          TableScreen(),
          OrderScreen(),
          MessageScreen(),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: _onTap,
          elevation: 12.5,
          selectedLabelStyle: const TextStyle(color: secondaryColors),
          type: BottomNavigationBarType.fixed,
          currentIndex: _pageIndex,
          items: [
            BottomNavigationBarItem(
                activeIcon: Image.asset("assets/images/profile_dark.png"),
                icon: Image.asset("assets/images/profile.png"),
                label: "Table"),
            BottomNavigationBarItem(
                activeIcon: Image.asset("assets/images/order_dark.png"),
                icon: Image.asset("assets/images/order.png"),
                label: "Order"),
            BottomNavigationBarItem(
                activeIcon: Image.asset("assets/images/message_dark.png"),
                icon: Image.asset("assets/images/message.png"),
                label: "Message"),
            BottomNavigationBarItem(
                activeIcon: Image.asset("assets/images/profile_dark.png"),
                icon: Image.asset("assets/images/profile.png"),
                label: "Profile")
          ]),
    );
  }
}
