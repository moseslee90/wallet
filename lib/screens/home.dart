import 'package:flutter/material.dart';
import './home/accounts_card.dart';
import './home/drawer.dart';
import './home/items_card.dart';
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
        color: Color(OFF_WHITE_INT),
        child: ListView(
          children: <Widget>[
            AccountsCard(),
            ItemsCard(),
            Container(
              height: 100,
              child: SizedBox.shrink(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed((context), PATH_ITEM_ADD),
        child: Icon(Icons.add),
      ),
    );
  }
}
