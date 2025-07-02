import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:egypt_plate_input/egypt_plate_input.dart';

void main() {
 TextEditingController field1Controller = TextEditingController();
 TextEditingController field2Controller = TextEditingController();
 TextEditingController field3Controller = TextEditingController();
 TextEditingController numberController = TextEditingController();
  test('adds one to input values', () {
    final carNumberWidget = EgyptPlateInput(
      field1Controller: field1Controller,
      field2Controller: field2Controller,
      field3Controller: field3Controller,
      numberController: numberController,
    );

    expect(carNumberWidget, isA<EgyptPlateInput>());
  });

}
