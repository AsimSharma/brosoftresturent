import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 0.060.h(context),
        width: 0.060.w(context),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/cance_icons.png"))),
      ),
    );
  }
}
