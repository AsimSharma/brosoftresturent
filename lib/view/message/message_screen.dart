import 'package:brosoftresturent/controller/remote_order_controller.dart';
import 'package:brosoftresturent/controller/remote_productcontroller.dart';
import 'package:brosoftresturent/utils/app_style.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/custome_btns.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final remoteProductsCtrl = Get.put(RemoteProductCtrl());
  @override
  void initState() {
    remoteProductsCtrl.getRemoteProductsItems();
    super.initState();
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
            )
          ],
        ),
      ),
    );
  }
}
