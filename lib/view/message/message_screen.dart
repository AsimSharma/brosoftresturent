import 'package:brosoftresturent/controller/remote_productcontroller.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../widgets/shared/custome_btns.dart';

import 'dart:developer';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen>
    with TickerProviderStateMixin {
  final remoteProductsCtrl = Get.put(RemoteProductCtrl());
  late final AnimationController _controller;
  @override
  void initState() {
    remoteProductsCtrl.getRemoteProductsItems();
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 0.15.h(context),
            ),
            Center(
              child: CustomBtn(
                height: 0.07.h(context),
                width: 0.7.w(context),
                btnTitle: "Get Remote Products Data",
                onPressed: () {
                  remoteProductsCtrl.getRemoteProductsItems();
                },
              ),
            ),
            SizedBox(
              height: 0.15.h(context),
            ),
            Container(
              height: 0.2.h(context),
              width: 1.0.w(context),
              color: Colors.green,
              child: Lottie.asset(
                "assets/animations/building_animations.json",
                controller: _controller,
                onLoaded: (composition) {
                  _controller.duration = composition.duration;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () => _controller.stop(),
                    child: const Text('Pause')),
                ElevatedButton(
                    onPressed: () => _controller.forward(),
                    child: const Text('Resume')),
                ElevatedButton(
                    onPressed: () {
                      _controller.reset();
                      _controller.forward();
                    },
                    child: const Text('Repeat'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
