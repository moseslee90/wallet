import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallet/database_helpers.dart' as databaseHelper;

import './account.dart';
import './accounts.dart';
import './categories.dart';
import './category.dart';
import './item.dart';
import './items.dart';
import '../common/constants.dart';

class StoreModel extends ChangeNotifier {
  /// Internal, private state of items

  final dbInstance = databaseHelper.DatabaseHelper.instance;

  ItemsModel items = ItemsModel({});
  AccountsModel accounts = AccountsModel({});
  CategoriesModel categories = CategoriesModel({});

  StoreModel() {
    _getStoreFromDb();
  }

  _getStoreFromDb() async {
    await _getItemsFromDb();
    await _getAccountsFromDb();
    await _getCategoriesFromDb();
    if (items.items.isEmpty &&
        accounts.accounts.isEmpty &&
        categories.categories.isEmpty) {
      await _loadSeedData();
      _getStoreFromDb();
    }
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
      await updateTotalsForAccounts();

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  _getCategoriesFromDb() async {
    try {
      categories.categories = await dbInstance.queryCategories();
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

  addItem(String name, double amount, int accountId, int categoryId,
      int transactionType, int accountTransferToId) async {
    var item = ItemModel(
        name: name,
        amount: amount,
        accountId: accountId,
        categoryId: categoryId,
        transactionType: transactionType,
        accountTransferToId: accountTransferToId);
    try {
      final id = await dbInstance.insertItem(item);
      item.id = id;
      items.addItem(item);
      await updateTotalsForAccounts();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  updateItem(int id, String name, double amount, int accountId, int categoryId,
      int transactionType, int accountTransferToId) async {
    var item = ItemModel(
        id: id,
        name: name,
        amount: amount,
        accountId: accountId,
        categoryId: categoryId,
        transactionType: transactionType,
        accountTransferToId: accountTransferToId);
    try {
      await dbInstance.updateItem(item);
      items.updateItem(item);
      await updateTotalsForAccounts();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  addCategory(String name, int color) async {
    var category = CategoryModel(null, name, color);
    try {
      final id = await dbInstance.insertCategory(category);
      category.id = id;
      categories.addCategory(category);

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  updateAccountPositions(List<AccountModel> accountModelList) async {
    for (var i = 0; i < accountModelList.length; i++) {
      AccountModel account = accountModelList[i];
      account.position = i;
      try {
        await dbInstance.updateAccount(account);
      } catch (e) {
        print(e);
      }
    }
    await _getAccountsFromDb();
  }

  updateTotalsForAccounts() async {
    accounts.accounts.forEach((id, account) {
      final total = items.getTotalForAccount(id);
      account.total = total;
    });
  }

  _loadSeedData() async {
    try {
      final CategoryModel transferCategory =
          CategoryModel(null, 'Transfer, Withdraw', ORANGE_INT);
      transferCategoryId = await dbInstance.insertCategory(transferCategory);
      addCategory('Salary', GREEN_INT);
      addCategory('Food', ORANGE_INT);
      addCategory('Shopping', BLUE_INT);
      addAccount('Grab Pay', GREEN_INT);
      addAccount('Bank', BLUE_INT);
      addAccount('Cash', ORANGE_INT);
      addItem("Chicken Rice", 3.6, 1, 3, EXPENSE_INT, null);
      addItem("Beef Noodles", 5, 2, 3, EXPENSE_INT, null);
      addItem("Char Siew Bao", 0.8, 1, 3, EXPENSE_INT, null);
      addItem("Keyboard", 0, 3, 4, EXPENSE_INT, null);
      addItem("Salary", 100, 2, 2, INCOME_INT, null);
      addItem("Transfer to Cash", 100, 2, 2, TRANSFER_INT, 3);
    } catch (e) {
      print(e);
    }
  }
}
