import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

class CustommizeScreen extends StatelessWidget {
  const CustommizeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: 0.92.h(context),
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 0.012.toResponsive(context),
        right: 0.012.toResponsive(context),
      ),
      child: Column(children: [Container(), const Text("Helooo bibek ")]),
    ));
  }
}
