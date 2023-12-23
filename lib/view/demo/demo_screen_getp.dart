import 'package:brosoftresturent/utils/app_style.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/crud_controller.dart';

class GetDemoProducts extends StatefulWidget {
  const GetDemoProducts({
    super.key,
  });

  @override
  State<GetDemoProducts> createState() => _GetDemoProductsState();
}

class _GetDemoProductsState extends State<GetDemoProducts> {
  final crudController = Get.put(CrudController());

  @override
  void initState() {
    crudController.getDemoProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: secondaryColors,
        height: 1.0.h(context),
        width: 1.0.w(context),
        child: Column(
          children: [
            Obx(() => Text("${crudController.demoProducts.length}")),
            for (int i = 0; i < crudController.demoProducts.length; i++)
              for (int j = 0;
                  j < crudController.demoProducts[i].productItem.length;
                  j++)
                Text(crudController.demoProducts[i].productName)
          ],
        ),
      ),
    );
  }
}
