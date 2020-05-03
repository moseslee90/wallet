import 'package:flutter/material.dart';
import 'package:wallet/Common/appbar.dart' as myAppBar;
import './home/accounts.dart' as accounts;

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: myAppBar.MyAppBar(),
      body: Container(
        child: ListView(
          children: <Widget>[
            accounts.Accounts()
          ],
        ),
      ),
    );
  }
}
