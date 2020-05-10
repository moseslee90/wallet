import 'package:flutter/material.dart';
import 'package:wallet/common/appbar.dart';

class MyScaffold extends StatelessWidget {
  final Widget body;
  final FloatingActionButton floatingActionButton;

  MyScaffold({this.body, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyAppBar(),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
