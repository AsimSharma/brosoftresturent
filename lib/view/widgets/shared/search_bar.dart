import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_style.dart';

class SearchBarContainer extends StatelessWidget {
  const SearchBarContainer({
    super.key,
    this.width = double.infinity,
    required this.onChangeValue,
    required this.hintText,
  });

  final double width;
  final dynamic onChangeValue;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.065.h(context),
      width: width,
      // margin: EdgeInsets.only(left: 0.0055.toResponsive(context)),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.2,
          style: BorderStyle.solid,
          color: textColor,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 0.06.h(context),
            width: 0.12.w(context),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/searchicons.png"),
              ),
            ),
          ),
          SizedBox(
            height: 0.89.h(context),
            width: 0.45.w(context),
            child: Padding(
              padding: EdgeInsets.all(0.0027.toResponsive(context)),
              child: TextField(
                onChanged: onChangeValue,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                      color: textColor,
                      fontSize: 0.014.toResponsive(context),
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w900),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
