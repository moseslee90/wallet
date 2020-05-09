import 'package:flutter/material.dart';
import 'package:wallet/common/appbar.dart';

class MyScaffold extends StatelessWidget {
  final Widget child;

  MyScaffold(this.child);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyAppBar(),
      body: child,
    );
  }
}
