import 'package:brosoftresturent/utils/app_style.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

class CustomeInputs extends StatefulWidget {
  const CustomeInputs({
    super.key,
    this.textEditingController,
    required this.hintText,
    this.validators,
    required this.textinputTypes,
  });

  final TextEditingController? textEditingController;
  final String hintText;
  final dynamic validators;
  final TextInputType textinputTypes;

  @override
  State<CustomeInputs> createState() => _CustomeInputsState();
}

class _CustomeInputsState extends State<CustomeInputs> {
  bool obscureTextbool = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      validator: widget.validators,
      controller: widget.textEditingController,
      keyboardType: widget.textinputTypes,
      decoration: InputDecoration(
        hintStyle:
            myTextStyle(textColor, 0.015.toResponsive(context), "Roboto"),
        focusColor: primary,
        hoverColor: primary,
        fillColor: primary,
        hintText: widget.hintText,
        filled: true,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: secondaryColors, width: 2)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: secondaryColors, width: 2)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: secondaryColors, width: 2)),
      ),
    );
  }
}

// class SearchBarIcons extends StatelessWidget {
//   const SearchBarIcons(
//       {super.key,
//       required this.searchController,
//       required this.iconsString,
//       required this.hinTexxt});

//   final TextEditingController searchController;
//   final String hinTexxt;
//   final String iconsString;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: TextField(
//           controller: searchController,
//           decoration: InputDecoration(
//             hintText: hinTexxt,
//             prefix: Image.asset(iconsString),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
