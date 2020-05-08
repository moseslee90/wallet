import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './item.dart';
import 'package:wallet/database_helpers.dart' as databaseHelper;

class ItemsModel {
  /// Internal, private state of items

  Map<int, ItemModel> items = {};

  ItemsModel(this.items);

  ItemModel getItemById(int id) => items[id];

  List<ItemModel> getForAccountId(int accountId) {
    List<ItemModel> result = [];
    items.forEach((_, value) {
      if (value.accountId == accountId) {
        result.add(value);
      }
    });
    return result;
  }

  int getTotalForAccount(int accountId) {
    int result = 0;
    items.forEach((_, value) {
      result += value.amount;
    });
    return result;
  }

  addItem(ItemModel item) {
    items[item.id] = item;
  }
}
