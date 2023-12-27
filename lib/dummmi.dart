
// class OrderCartController extends GetxController {
//   var orderCartList = <OrderCart>[].obs;

//   void addOrUpdateOrderCart(ProductItem productItem) {
//     // Check if the product is already added to any order
//     var existingOrder = orderCartList.firstWhere(
//       (order) => order.productItems.any((item) => item.id == productItem.id),
//       orElse: () => null,
//     );

//     if (existingOrder != null) {
//       // If product is already in an order, update its quantity
//       existingOrder.updateQuantity(productItem);
//     } else {
//       // If product is not in any order, create a new order
//       var newOrderCart = OrderCart(
//         tableName: 'Table 1', // Example table name
//         totalGuest: 4, // Example total guest count
//         orderNo: orderCartList.length + 1,
//         totalprices: productItem.prices,
//         productItems: [productItem],
//       );
//       orderCartList.add(newOrderCart);
//     }
//   }
// }

// class OrderCart {
//   // ... existing code ...

//   void updateQuantity(ProductItem productItem) {
//     var existingItem = productItems.firstWhere(
//       (item) => item.id == productItem.id,
//       orElse: () => null,
//     );

//     if (existingItem != null) {
//       // If product is already in the order, increase its quantity
//       existingItem.quantity += productItem.quantity;
//       // Update total prices based on the increased quantity
//       totalprices += (productItem.prices * productItem.quantity);
//     }
//   }
// }