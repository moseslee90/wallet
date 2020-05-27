import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/constants.dart';
import 'package:wallet/models/account.dart';
import 'package:wallet/models/item.dart';
import 'package:wallet/models/store.dart';

class ItemsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var _store = Provider.of<StoreModel>(context);
    Map<int, AccountModel> _accounts = _store.accounts.accounts;
    List<ItemModel> _items = _store.items.items.values.toList();
    return Container(
        child: _ItemList(_items, _accounts),
    );
  }
}

class _ItemList extends StatelessWidget {
  final List<ItemModel> _items;
  final Map<int, AccountModel> _accounts;
  _ItemList(this._items, this._accounts);

  @override
  Widget build(BuildContext context) {
    List<Widget> _itemList = [];
    for (var _item in _items) {
      final _accountName = _accounts[_item.accountId].name;
      _itemList.add(_ItemRow(_item, _accountName));
    }
    // TODO: implement build
    return Column(
      children: _itemList,
    );
  }
}

class _ItemRow extends StatelessWidget {
  final ItemModel _item;
  final String _accountName;
  _ItemRow(this._item, this._accountName);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final String _itemName = _item.name;
    final String _amount = _item.amount.toString();
    return Row(
      children: <Widget>[
        Text(_accountName),
        Text(_itemName),
        Text(_amount),
      ],
    );
  }
}
