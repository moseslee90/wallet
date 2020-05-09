import 'package:flutter/material.dart';
import './home/accounts_card.dart';
import 'package:wallet/common/scaffold.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyScaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            AccountsCard()
          ],
        ),
      ),
    );
  }
}
