import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './item.dart';
import './items.dart';
import './accounts.dart';
import './account.dart';
import './category.dart';
import './categories.dart';

import 'package:wallet/database_helpers.dart' as databaseHelper;

class StoreModel extends ChangeNotifier {
  /// Internal, private state of items

  final dbInstance = databaseHelper.DatabaseHelper.instance;

  ItemsModel items = ItemsModel({});
  AccountsModel accounts = AccountsModel();
  CategoriesModel categories = CategoriesModel({});


  StoreModel() {
    _getStoreFromDb();
  }

  _getStoreFromDb() async {
    await _getItemsFromDb();
    await _getAccountsFromDb();
  }

  _getItemsFromDb() async {
    try {
      items.items = await dbInstance.queryItems();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  _getAccountsFromDb() async {
    try {
      accounts.accounts = await dbInstance.queryAccounts();
      accounts.accounts.forEach((id, account) {
        final total = items.getTotalForAccount(id);
        account.total = total;
      });

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  addAccount(String name, int color) async {
    var account = AccountModel(null, name, color);
    try {
      final id = await dbInstance.insertAccount(account);
      account.id = id;
      accounts.addAccount(account);

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  addItem(String name, int amount, int accountId, int categoryId, int transactionType) async {
    var item = ItemModel(name: name, amount: amount, accountId: accountId, categoryId: categoryId, transactionType: transactionType);
    try {
      final id = await dbInstance.insertItem(item);
      item.id = id;
      items.addItem(item);

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  addCategory(String name) async {
    var category = CategoryModel(null, name);
    try {
      final id = await dbInstance.insertCategory(category);
      category.id = id;
      categories.addCategory(category);

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
