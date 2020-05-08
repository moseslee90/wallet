import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './item.dart' as item;
import 'package:wallet/database_helpers.dart' as databaseHelper;

class ItemsModel {
  /// Internal, private state of items

  Map<int, item.ItemModel> _items = {};

  ItemsModel(this._items);

  Map<int, item.ItemModel> get items => _items;
  set items(Map<int, item.ItemModel> value) {
    this._items = value;
  }

  item.ItemModel getItemById(int id) => _items[id];

  List<item.ItemModel> getForAccountId(int accountId) {
    List<item.ItemModel> result = [];
    _items.forEach((_, value) {
      if (value.accountId == accountId) {
        result.add(value);
      }
    });
    return result;
  }

  int getTotalForAccount(int accountId) {
    int result = 0;
    _items.forEach((_, value) {
      result += value.amount;
    });
    return result;
  }
}
