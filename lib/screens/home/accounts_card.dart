import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/constants.dart';
import 'package:wallet/models/account.dart';
import 'package:wallet/models/accounts.dart';
import 'package:wallet/models/store.dart';

class AccountsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var store = Provider.of<StoreModel>(context);
    return Container(
        child: Column(
      children: <Widget>[
        _Header(),
        AccountIconsGrid(store.accounts),
        GestureDetector(
          onTap: () {},
          child: Text('update accounts'),
        ),
      ],
    ));
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 6.0, top: 6.0, bottom: 10.0),
      child: Row(
        children: <Widget>[
          Text(LIST_OF_ACCOUNTS),
          _SettingsIcon(),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}

class _SettingsIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ADD_ACCOUNT_PATH);
        //do something with store when this is clicked
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: Icon(Icons.settings, size: 20.0),
          ),
        ),
      ),
    );
  }
}

class AccountIconsGrid extends StatelessWidget {
  final AccountsModel accounts;

  AccountIconsGrid(this.accounts);

  List<AccountIcon> _accountIcons() {
    List<AccountIcon> result = [];
    accounts.accounts.forEach((_, value) => result.add(AccountIcon(value)));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: <Widget>[
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              alignment: WrapAlignment.start,
              children: _accountIcons(),
            )
          ],
        ));
  }
}

class AccountIcon extends StatelessWidget {
  final AccountModel account;

  AccountIcon(this.account);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        color: Color(account.color),
        child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
              width: 100,
              height: 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    account.name,
                    style: TextStyle(
                      color: Colors.grey.shade300,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(account.totalToString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            )));
  }
}
