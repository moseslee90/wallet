import 'package:flutter/material.dart';
import './home/accounts_card.dart';
import './home/drawer.dart';
import 'package:wallet/common/scaffold.dart';
import '../common/constants.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyScaffold(
      appBar: AppBar(
        title: Text(HOME),
      ),
      drawer: HomeDrawer(),
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
