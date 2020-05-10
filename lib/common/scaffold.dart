import 'package:flutter/material.dart';
import 'package:wallet/common/appbar.dart';

class MyScaffold extends StatelessWidget {
  final Widget body;
  final FloatingActionButton floatingActionButton;
  final AppBar appBar;
  final Drawer drawer;

  MyScaffold({this.body, this.floatingActionButton, this.appBar, this.drawer});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: appBar ?? MyAppBar(),
      drawer: drawer,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
