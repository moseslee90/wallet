import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/constants.dart' as constants;
import 'package:wallet/models/account.dart' as accountModel;
import 'package:wallet/models/accounts.dart' as accountsModel;

class AccountsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var accountModels = Provider.of<accountsModel.AccountsModel>(context);
    return Container(
        child: Column(
      children: <Widget>[
        _Header(),
        AccountIconsGrid(accountModels),
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
          Text(constants.LIST_OF_ACCOUNTS),
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
    return Card(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        child: Center(
          child: Icon(Icons.settings, size: 20.0),
        ),
      ),
    );
  }
}

class AccountIconsGrid extends StatelessWidget {
  final accountsModel.AccountsModel accounts;

  AccountIconsGrid(this.accounts);

  List<AccountIcon> _accountIcons() {
    List<AccountIcon> result = [];
    accounts.accounts.forEach((key, value) => result.add(AccountIcon(value)));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      width: 250.0,
      child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        alignment: WrapAlignment.center,
        children: _accountIcons(),
      )
    );
  }
}

class AccountIcon extends StatelessWidget {
  final accountModel.AccountModel account;

  AccountIcon(this.account);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InputChip(
      label: Text(account.total.toString()),
      labelStyle: TextStyle(color: Colors.white),
      backgroundColor: account.color,
      onPressed: () {
        print('pressed');
      },
    );
  }
}
