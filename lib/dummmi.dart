
// List.generate(
//               btnlist.length,
//               (index) => InkWell(
//                     onTap: () {
//                       setState(() {
//                         btnTapIndex = index;
//                       });
//                     },
//                     child: Container(
//                       height: 0.8.h(context),
//                       width: 0.2.w(context),
//                       margin: const EdgeInsets.only(left: 5),
//                       decoration: BoxDecoration(
//                           color:
//                               btnTapIndex == index ? secondaryColors : primary,
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(50))),
//                       child: Center(
//                           child: Text(
//                         btnlist[index],
//                         style: myTextStyle(
//                             btnTapIndex != index ? secondaryColors : primary,
//                             0.008.toResponsive(context),
//                             " Roboto"),
//                       )),
//                     ),
//                   ))