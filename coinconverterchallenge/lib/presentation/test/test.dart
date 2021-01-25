import 'package:coinconverterchallenge/presentation/test/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {

  TestController controller;

  @override
  Widget build(BuildContext context) {
    controller = controller == null ? Provider.of<TestController>(context) : controller;

    controller.test();

    return Container(color: Colors.white,);
  }
}
