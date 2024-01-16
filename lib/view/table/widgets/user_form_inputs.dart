import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

import '../../widgets/shared/custome_inputs.dart';

class UserFormInputs extends StatelessWidget {
  const UserFormInputs({
    super.key,
    required this.nameController,
    required this.numberController,
    required this.customernoController,
  });

  final TextEditingController nameController;
  final TextEditingController numberController;
  final TextEditingController customernoController;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(children: [
        SizedBox(
          height: 0.07.h(context),
          width: 1.0.w(context),
          child: CustomeInputs(
              textEditingController: nameController,
              hintText: "Name",
              textinputTypes: TextInputType.text),
        ),
        SizedBox(
          height: 0.01.h(context),
        ),
        SizedBox(
          height: 0.07.h(context),
          width: 1.0.w(context),
          child: CustomeInputs(
              textEditingController: numberController,
              hintText: "Number",
              textinputTypes: TextInputType.number),
        ),
        SizedBox(
          height: 0.01.h(context),
        ),
        SizedBox(
          height: 0.07.h(context),
          width: 1.0.w(context),
          child: CustomeInputs(
              textEditingController: customernoController,
              hintText: "Customer No",
              textinputTypes: TextInputType.number),
        ),
      ]),
    );
  }
}
