import 'package:brosoftresturent/model/tables_model.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:brosoftresturent/view/widgets/shared/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/table_controller.dart';
import '../../../utils/app_style.dart';
import '../../widgets/shared/logo_app_bar.dart';
import '../models/btnmodels.dart';
import '../widgets/category_selectedbtn.dart';
import '../widgets/table_grids.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  int btnTapIndex = 0;
  final tableController = Get.put(TableController());

  String searchValue = "";

  bool isReserved = false;

  List<TableModel> filterItems() {
    if (searchValue.isNotEmpty) {
      return tableController.tables
          .where((product) =>
              product.tabletype.toLowerCase().contains(searchValue))
          .toList();
    } else {
      if (btnTapIndex == 0) {
        return tableController.tables;
      } else {
        var selectedItem = btnlist[btnTapIndex];
        return tableController.tables
            .where((product) => selectedItem == product.tabletype)
            .toList();
      }
    }
  }

  @override
  void initState() {
    btnTapIndex = 0;
    tableController.getTables();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool reservedww = false;

  @override
  Widget build(BuildContext context) {
    var filterTable = filterItems();

    return Scaffold(
      backgroundColor: Colors.white60,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 0.01.toResponsive(context),
          right: 0.01.toResponsive(context),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 0.025.h(context),
              ),
              const LogoAppBar(),
              SizedBox(
                height: 0.015.h(context),
              ),
              SearchBarContainer(
                onChangeValue: (value) {
                  setState(() {
                    searchValue = value;
                  });
                },
              ),
              SizedBox(
                height: 0.015.h(context),
              ),
              //categorselectedbtns
              categoryselectedbtn(context),
              SizedBox(
                height: 0.015.h(context),
              ),

              // llistedTableItems(context, filterTable)
              Obx(() => tableController.isLooding == false.obs
                  ? const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: secondaryColors,
                      ),
                    )
                  : TableGridItem(filterTable: filterTable))
            ],
          ),
        ),
      ),
    );
  }

  Container categoryselectedbtn(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0.0035.toResponsive(context)),
      padding: EdgeInsets.only(left: 0.0035.toResponsive(context)),
      height: 0.05.h(context),
      width: 1.0.w(context),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: btnlist.length,
          itemBuilder: (context, index) {
            return CategoryselectedBtns(
              btnTapIndex: btnTapIndex,
              index: index,
              onPressed: () {
                setState(() {
                  btnTapIndex = index;
                });
              },
            );
          }),
    );
  }
}
