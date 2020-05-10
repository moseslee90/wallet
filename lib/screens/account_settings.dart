import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/constants.dart';
import 'package:wallet/common/scaffold.dart';
import 'package:wallet/models/account.dart';
import 'package:wallet/models/accounts.dart';
import 'package:wallet/models/store.dart';
import 'package:provider/provider.dart';
import 'package:wallet/models/store.dart';

class AccountSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyScaffold(
      body: Container(
        child: _AccountsList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, PATH_ACCOUNT_ADD),
        child: Icon(Icons.add),
      ),
    );
  }
}

class _AccountsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AccountsModel _accounts = Provider.of<StoreModel>(context).accounts;
    List<AccountModel> _accountModels = [];
    _accounts.accounts.forEach((_, account) {
      _accountModels.add(account);
    });
    _accountModels.sort((a, b) => a.position - b.position);
    List<_AccountRow> _accountRows =
        _accountModels.map((account) => _AccountRow(account)).toList();

    return ListView(
      children: _accountRows,
    );
  }
}

class _AccountRow extends StatelessWidget {
  final AccountModel account;

  _AccountRow(this.account);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _AccountIcon(account.color),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 5.0),
              child: _AccountDetails(account.name),
            ),
          ),
          Container(
            height: 25,
            width: 25,
            child: Icon(Icons.drag_handle),
          ),
        ],
      ),
    );
  }
}

class _AccountIcon extends StatelessWidget {
  final int color;

  _AccountIcon(this.color);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      color: Color(color),
      child: Container(
        height: 35,
        width: 35,
        child: Icon(Icons.attach_money),
      ),
    );
  }
}

class _AccountDetails extends StatelessWidget {
  final String name;

  _AccountDetails(this.name);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(name),
        Text('some other stuff'),
      ],
    );
  }
}
