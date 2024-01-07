import 'package:brosoftresturent/utils/app_style.dart';
import 'package:flutter/material.dart';

class NotifactionsModels {
  final String nTitile;
  final String descriptions;
  final String tableName;
  final Color nColors;
  final String niconsImages;

  NotifactionsModels(
      {required this.nTitile,
      required this.descriptions,
      required this.tableName,
      required this.nColors,
      required this.niconsImages});
}

final notifactionsDataList = [
  NotifactionsModels(
      nTitile: "Meal Ready",
      descriptions: "Order no 130 meal is ready for serve.",
      tableName: "Table 2A",
      nColors: const Color.fromARGB(162, 244, 67, 54),
      niconsImages: "assets/images/mealWhite.png"),
  NotifactionsModels(
      nTitile: "Meal Ready",
      descriptions: "Order no 130 meal is ready for serve.",
      tableName: "Table 2A",
      nColors: const Color.fromARGB(191, 255, 153, 0),
      niconsImages: "assets/images/bervageWhite.png"),
  NotifactionsModels(
      nTitile: "Meal Ready",
      descriptions: "Order no 130 meal is ready for serve.",
      tableName: "Table 2A",
      nColors: const Color.fromARGB(157, 0, 115, 255),
      niconsImages: "assets/images/perssonacc.png"),
  NotifactionsModels(
      nTitile: "Meal Ready",
      descriptions: "Order no 130 meal is ready for serve.",
      tableName: "Table 2A",
      nColors: const Color.fromARGB(175, 104, 58, 183),
      niconsImages: "assets/images/mealWhite.png"),
  NotifactionsModels(
      nTitile: "Meal Ready",
      descriptions: "Order no 130 meal is ready for serve.",
      tableName: "Table 2A",
      nColors: const Color.fromARGB(128, 8, 225, 182),
      niconsImages: "assets/images/bervageWhite.png"),
  NotifactionsModels(
      nTitile: "Meal Ready",
      descriptions: "Order no 130 meal is ready for serve.",
      tableName: "Table 2A",
      nColors: const Color.fromARGB(175, 104, 58, 183),
      niconsImages: "assets/images/mealWhite.png"),
  NotifactionsModels(
      nTitile: "Meal Ready",
      descriptions: "Order no 130 meal is ready for serve.",
      tableName: "Table 2A",
      nColors: const Color.fromARGB(191, 255, 153, 0),
      niconsImages: "assets/images/bervageWhite.png"),
];
