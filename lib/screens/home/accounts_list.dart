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
          AccountsIconList(accountModels),
        ],
      )
    );
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

class AccountsIconList extends StatelessWidget {
  final accountsModel.AccountsModel accounts;

  AccountsIconList(this.accounts);

  List<AccountIcon>_accountIcons() {
    List<AccountIcon> result = [];
    accounts.accounts.forEach((key, value) => result.add(AccountIcon(value)));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Row(
      children: _accountIcons(),
    );
  }
}

class AccountIcon extends StatelessWidget {
  final accountModel.AccountModel account;
  AccountIcon(this.account);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(account.total.toString());
  }
}
