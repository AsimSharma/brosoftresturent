import 'package:brosoftresturent/controller/table_controller.dart';
import 'package:brosoftresturent/utils/app_style.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:brosoftresturent/view/widgets/custome_inputs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'models/btnModels.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  int btnTapIndex = 0;
  final tableController = Get.put(TableController());
  @override
  void initState() {
    tableController.getTables();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("${tableController.products.length}");
    return Scaffold(
        body: Obx(
      () => SafeArea(
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: ListView(children: [
                logoHeader(context),
                searchBar(context),
                //
                const SizedBox(
                  height: 15,
                ),
                selectedBtn(context),
                const SizedBox(
                  height: 15,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "Ground Floor",
                    style: myTextStyle(
                        textColor, 0.013.toResponsive(context), "Roboto"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                //gridContainer
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  height: 350,
                  width: 1.0.w(context),
                  child: Stack(
                    children: [
                      GridView.builder(
                          itemCount: tableController.products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) => Card(
                                color:
                                    tableController.products[index].reserved ==
                                            true
                                        ? reservedColor
                                        : primary,
                                child: Stack(children: [
                                  Positioned(
                                    top: 10,
                                    left: 20,
                                    child: Container(
                                      child: Text(tableController
                                          .products[index].tableName),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    height: 20,
                                    left: 10,
                                    width: 1.0.w(context),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          height: 25,
                                          width: 25,
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/imageperson.png"))),
                                        ),
                                        Text(
                                            "${tableController.products[index].number.toString()} people"),
                                      ],
                                    ),
                                  ),
                                ]),
                              )),
                      Positioned(
                        bottom: 1,
                        child: Text("hello Bibek"),
                      )
                    ],
                  ),
                )
              ]))),
    ));
  }

  Container selectedBtn(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 30,
      width: 0.1.w(context),
      child: Row(
        children: [
          ...List.generate(
              btnlist.length,
              (index) => InkWell(
                    onTap: () {
                      setState(() {
                        btnTapIndex = index;
                      });
                    },
                    child: Container(
                      height: 30,
                      width: 80,
                      margin: const EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                          color:
                              btnTapIndex == index ? secondaryColors : primary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50))),
                      child: Center(
                          child: Text(
                        btnlist[index],
                        style: myTextStyle(
                            btnTapIndex != index ? secondaryColors : primary,
                            0.008.toResponsive(context),
                            " Roboto"),
                      )),
                    ),
                  ))
        ],
      ),
    );
  }

  Container searchBar(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: 0.06.h(context),
        width: 1.0.w(context),
        decoration: BoxDecoration(
            // color: Colors.red,
            boxShadow: const [
              BoxShadow(
                  color: primary,
                  offset: Offset(0.0, 0.1),
                  blurRadius: 0.5,
                  spreadRadius: 0.5)
            ],
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(Radius.circular(40))),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            height: 100,
            width: 0.2.w(context),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/searchicons.png"))),
          ),
          Expanded(
            child: SizedBox(
              height: 120,
              width: 0.7.w(context),
              child: const CustomeInputs(
                  hintText: "search by table or caterozie",
                  textinputTypes: TextInputType.text),
            ),
          )
        ]),
      );

  Container logoHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: primary,
      height: 0.15.h(context),
      width: 1.0.w(context),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 0.08.h(context),
                  width: 0.2.w(context),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/logo_images.png"))),
                ),
                SizedBox(
                  width: 0.0040.w(context),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      logoText,
                      style: myTextStyle(
                          textColor, 0.018.toResponsive(context), "Roboto"),
                    ),
                    Text(
                      address,
                      style: myTextStyle(
                          textColor, 0.011.toResponsive(context), "Roboto"),
                    )
                  ],
                ),
                SizedBox(
                  width: 0.0030.w(context),
                ),
              ],
            ),
            IconButton(
                onPressed: () {},
                icon: Image.asset("assets/images/notification.png"))
          ]),
    );
  }
}
