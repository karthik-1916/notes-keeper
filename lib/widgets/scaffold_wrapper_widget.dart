import 'package:flutter/material.dart';

class ScaffoldWrapperWidget extends StatelessWidget {
  final Widget drawer;
  final Widget appBar;
  final Widget body;
  final Widget floatingActionButton;

  ScaffoldWrapperWidget({
    @required this.appBar,
    @required this.body,
    this.drawer,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
