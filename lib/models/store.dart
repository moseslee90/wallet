import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './item.dart';
import './items.dart';
import './accounts.dart';
import './account.dart';
import './category.dart';
import './categories.dart';
import '../common/constants.dart';

import 'package:wallet/database_helpers.dart' as databaseHelper;

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
    if(items.items == {} && accounts.accounts == {} && categories.categories == {}) {
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
      final CategoryModel foodCategory = CategoryModel(null, 'Food', ORANGE_INT);
      await dbInstance.insertCategory(foodCategory);
      final CategoryModel shoppingCategory = CategoryModel(null, 'Shopping', BLUE_INT);
      await dbInstance.insertCategory(shoppingCategory);
      final AccountModel grabAccount = AccountModel(null, 'Grab Pay', GREEN_INT);
      await dbInstance.insertAccount(grabAccount);
      final AccountModel bankAccount = AccountModel(null, 'Bank', BLUE_INT);
      await dbInstance.insertAccount(bankAccount);
      final AccountModel cashAccount = AccountModel(null, 'Cash', ORANGE_INT);
      await dbInstance.insertAccount(cashAccount);
      final ItemModel chickenRice = ItemModel(name: "Chicken Rice", amount: 3.6, accountId: 1, categoryId: 1, transactionType: EXPENSE_INT);
      await dbInstance.insertItem(chickenRice);;
      final ItemModel beefNoodles = ItemModel(name: "Beef Noodles", amount: 5, accountId: 2, categoryId: 1, transactionType: EXPENSE_INT);
      await dbInstance.insertItem(beefNoodles);;
      final ItemModel charSiewBao = ItemModel(name: "Char Siew Bao", amount: 0.8, accountId: 1, categoryId: 1, transactionType: EXPENSE_INT);
      await dbInstance.insertItem(charSiewBao);;
      final ItemModel keyboard = ItemModel(name: "Keyboard", amount: 50, accountId: 3, categoryId: 2, transactionType: EXPENSE_INT);
      await dbInstance.insertItem(keyboard);
    } catch (e) {
      print(e);
    }
  }
}
