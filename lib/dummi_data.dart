
// SizedBox(
//                   height: 0.08.h(context),
//                   width: 1.0.w(context),
//                   child: ListView.builder(
//                     itemCount: 4,
//                     itemBuilder: (context, index) => Container(
//                       margin: const EdgeInsets.all(10),
//                       height: 20,
//                       width: 20,
//                       child: Obx(() => Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               children: [
//                                 Text(
//                                   "heloo",
//                                   style: myTextStyle(primary,
//                                       0.015.toResponsive(context), "Roboto"),
//                                 ),
//                                 Text(
//                                   productsController
//                                       .productList[btnTapIndex].productName,
//                                   style: myTextStyle(primary,
//                                       0.015.toResponsive(context), "Roboto"),
//                                 ),
//                               ],
//                             ),
//                           )),
//                     ),
//                   ),
//                 )
//               SizedBox(
//                   height: 0.35.h(context),
//                   width: 1.0.w(context),
//                   child: ListView.builder(
//                       itemCount: 4,
//                       scrollDirection: Axis.horizontal,
//                       itemBuilder: (context, index) {
//                         var ttt = productsController
//                             .productList[btnTapIndex].productItem[index];

//                         return Card(
//                           child: Obx(
//                             () => Container(
//                               margin: const EdgeInsets.only(left: 10),
//                               width: 0.5.w(context),
//                               child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                         height: 0.2.h(context),
//                                         width: 1.0.w(context),
//                                         color: Colors.black12),
//                                     Text(
//                                       productsController
//                                           .productList[btnTapIndex]
//                                           .productItem[index]
//                                           .itemName
//                                           .toString(),
//                                       style: myTextStyle(
//                                           secondaryColors,
//                                           0.015.toResponsive(context),
//                                           "Roboto"),
//                                     ),
//                                     Container(
//                                       color: Colors.red,
//                                       width: 0.5.w(context),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               const Text("Rs"),
//                                               Text(ttt.rs.toString()),
//                                             ],
//                                           ),
//                                           Text("Customize")
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 0.005.h(context),
//                                     ),
//                                     //btnIncre/decre
//                                     Container(
//                                       height: 35,
//                                       width: 150,
//                                       padding: const EdgeInsets.all(10),
//                                       decoration: const BoxDecoration(
//                                           color: secondaryColors,
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(15))),
//                                       child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             InkWell(
//                                                 onTap: () {
//                                                   log("increment");
//                                                 },
//                                                 child: Image.asset(
//                                                     "assets/images/Add icon.png")),
//                                             const VerticalDivider(
//                                               color: textColor,
//                                               width: 10,
//                                             ),
//                                             InkWell(
//                                                 onTap: () {},
//                                                 child: Image.asset(
//                                                     "assets/images/subtract icon.png"))
//                                           ]),
//                                     ),
//                                   ]),
//                             ),
//                           ),
//                         );
//                       })),