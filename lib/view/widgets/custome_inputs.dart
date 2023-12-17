// import 'package:flutter/material.dart';


// class CustomeInputs extends StatefulWidget {
//   const CustomeInputs(
//       {super.key,
//       this.textEditingController,
//       required this.hintText,
//       required this.icons,
//       this.validators,
//       required this.textinputTypes,
//       this.credentials = false,
//       this.inputFormatters});

//   final TextEditingController? textEditingController;
//   final String hintText;
//   final IconData icons;
//   final dynamic validators;
//   final TextInputType textinputTypes;
//   final bool credentials;
//   final dynamic inputFormatters;

//   @override
//   State<CustomeInputs> createState() => _CustomeInputsState();
// }

// class _CustomeInputsState extends State<CustomeInputs> {
//   bool obscureTextbool = true;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 0.075.h(context),
//       padding: const EdgeInsets.all(17),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(30),
//         color: inputcolor,
//       ),
//       child: TextFormField(
//         style: const TextStyle(color: Colors.black),
//         obscureText: obscureTextbool == widget.credentials ? true : false,
//         validator: widget.validators,
//         controller: widget.textEditingController,
//         keyboardType: widget.textinputTypes,
//         decoration: InputDecoration(
//             contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
//             focusColor: inputcolor,
//             hoverColor: inputcolor,
//             fillColor: inputcolor,
//             prefixIcon: Padding(
//               padding: const EdgeInsets.all(0.0),
//               child: FaIcon(
//                 widget.icons,
//                 color: Colors.black,
//               ),
//             ),
//             suffixIcon: widget.credentials
//                 ? Padding(
//                     padding: const EdgeInsets.all(0.0),
//                     child: IconButton(
//                       icon: obscureTextbool == widget.credentials
//                           ? const FaIcon(FontAwesomeIcons.eye)
//                           : const FaIcon(FontAwesomeIcons.eyeSlash),
//                       onPressed: () {
//                         setState(() {
//                           obscureTextbool = !obscureTextbool;
//                         });
//                       },
//                     ),
//                   )
//                 : null,
//             hintText: widget.hintText,
//             filled: true,
//             border: InputBorder.none,
//             enabledBorder: InputBorder.none,
//             focusedBorder: InputBorder.none),
//       ),
//     );
//   }
// }

