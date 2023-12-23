import 'package:brosoftresturent/controller/crud_controller.dart';
import 'package:brosoftresturent/utils/app_style.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';

import 'package:brosoftresturent/view/demo/demo_screen_getp.dart';
import 'package:brosoftresturent/view/widgets/custome_btns.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../demo/demo_post_screen.dart';

import 'dart:developer';

import '../table/screen/selected_order.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final crudController = Get.put(CrudController());

  @override
  void initState() {
    crudController.getDemoProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 0.005.h(context),
          ),
          const Center(
            child: Text("Crud_operations"),
          ),
          SizedBox(
            height: 0.005.h(context),
          ),
          Center(
            child: Column(children: [
              CustomBtn(
                btnTitle: "GetDataasaSas",
                color: btnSecondaryColor,
                onPressed: () {
                  Get.to(
                    const GetDemoProducts(),
                  );
                },
              ),
              SizedBox(
                height: 0.005.h(context),
              ),
              CustomBtn(
                btnTitle: "PostData",
                color: Colors.green,
                onPressed: () {
                  log("postdtaaa");
                  Get.to(const DemoDataPostScreen());
                },
              ),
              SizedBox(
                height: 0.005.h(context),
              ),
              CustomBtn(
                btnTitle: "EditsData",
                onPressed: () {},
              ),
              SizedBox(
                height: 0.005.h(context),
              ),
              CustomBtn(
                btnTitle: "DeleteData",
                color: Colors.red,
                onPressed: () {},
              ),
              CustomBtn(
                btnTitle: "Selected order",
                color: secondaryColors,
                onPressed: () {
                  Get.to(const SelectedOrder());
                },
              )
            ]),
          )
        ],
      ),
    );
  }
}
