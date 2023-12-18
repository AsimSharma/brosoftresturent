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
    print("${tableController.products}");
    return Scaffold(
        body: SafeArea(
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

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    margin: const EdgeInsets.symmetric(horizontal: 13),
                    height: 350,
                    width: 1.0.w(context),
                    child: GridView.builder(
                        itemCount: 10,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemBuilder: (context, index) => Container(
                              child: Stack(children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  color: Colors.red,
                                )
                              ]),
                            )),
                  )
                ]))));
  }

  Container selectedBtn(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      margin: const EdgeInsets.symmetric(horizontal: 1),
      height: 30,
      width: 0.9.w(context),
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
