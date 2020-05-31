import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/constants.dart';
import 'package:wallet/common/scaffold.dart';
import 'package:wallet/models/account.dart';
import 'package:wallet/models/accounts.dart';
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
    StoreModel store = Provider.of<StoreModel>(context);
    AccountsModel _accounts = store.accounts;
    List<AccountModel> _accountModelList = [];
    _accounts.accounts.forEach((_, account) {
      _accountModelList.add(account);
    });
    _accountModelList.sort((a, b) => a.position - b.position);
    List<_AccountRow> _accountRows = [];
    for(int i = 0; i < _accountModelList.length; i++) {
      _accountRows.add(_AccountRow(_accountModelList[i], ValueKey(i.toString())));
    }

    return ReorderableListView(
      children: _accountRows,
      onReorder: (oldIndex, newIndex) {
        AccountModel old = _accountModelList[oldIndex];
        if (oldIndex > newIndex) {
          for (int i = oldIndex; i > newIndex; i--) {
            _accountModelList[i] = _accountModelList[i - 1];
          }
          _accountModelList[newIndex] = old;
        } else {
          for (int i = oldIndex; i < newIndex - 1; i++) {
            _accountModelList[i] = _accountModelList[i + 1];
          }
          _accountModelList[newIndex - 1] = old;
        }
        store.updateAccountPositions(_accountModelList);
      },
    );
  }
}

class _AccountRow extends StatelessWidget {
  final AccountModel account;
  final Key key;

  _AccountRow(this.account, this.key): super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      key: key,
      leading: _AccountIcon(account.color),
      title: Text(account.name),
      trailing: _DragHandle(),
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

class _DragHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 25,
      width: 25,
      child: Icon(Icons.drag_handle),
    );
  }
}
