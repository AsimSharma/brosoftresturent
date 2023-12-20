import 'package:brosoftresturent/utils/app_style.dart';
import 'package:flutter/material.dart';

class CustomeInputs extends StatefulWidget {
  const CustomeInputs(
      {super.key,
      this.textEditingController,
      required this.hintText,
      this.validators,
      required this.textinputTypes,
      this.inputFormatters});

  final TextEditingController? textEditingController;
  final String hintText;
  final dynamic validators;
  final TextInputType textinputTypes;
  final dynamic inputFormatters;

  @override
  State<CustomeInputs> createState() => _CustomeInputsState();
}

class _CustomeInputsState extends State<CustomeInputs> {
  bool obscureTextbool = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: primary,
      ),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        validator: widget.validators,
        controller: widget.textEditingController,
        keyboardType: widget.textinputTypes,
        decoration: InputDecoration(
            focusColor: primary,
            hoverColor: primary,
            fillColor: primary,
            hintText: widget.hintText,
            filled: true,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none),
      ),
    );
  }
}
