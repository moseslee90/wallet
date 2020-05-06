import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './account.dart' as account;
import 'package:wallet/common/constants.dart' as constants;
import 'package:wallet/database_helpers.dart' as databaseHelper;
import 'dart:math' as Math;

class AccountsModel extends ChangeNotifier {
  /// Internal, private state of accounts
//  Map<int, account.AccountModel> _accounts = {
////    1: account.AccountModel(1, 2000, Colors.blue.shade400),
//    1: account.AccountModel(1, 2000, constants.BLUE),
//    2: account.AccountModel(2, 3000, constants.GREEN),
//    3: account.AccountModel(3, 9000, constants.INDIGO),
//    4: account.AccountModel(4, 2500, constants.TEAL),
//    5: account.AccountModel(5, 3200, constants.ORANGE),
//  };

  Map<int, account.AccountModel> _accounts = {};
  
  AccountsModel() {
    databaseHelper.DatabaseHelper.instance.queryAccounts().then((onValue) {
      _accounts = onValue;
    });
  }

  Map<int, account.AccountModel> get accounts => _accounts;

  account.AccountModel getAccountById(int id) => _accounts[id];

  int getAccountTotalById(int id) => getAccountById(id).total;

  void setAccountTotal(int id, int total) {
    _accounts[id].total = total;

    notifyListeners();
  }

  updateAccountsFromDB() async {
    try {
      _accounts = await databaseHelper.DatabaseHelper.instance.queryAccounts();
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  insetRandomAccount() async {
    var randomId = Math.Random.secure().nextInt(100);
    var randomTotal = Math.Random.secure().nextInt(10000);
    var randomAccount = account.AccountModel(randomId, randomTotal, constants.INDIGO);
    try {
      await databaseHelper.DatabaseHelper.instance.insert(randomAccount);
      await updateAccountsFromDB();
    } catch (e) {
      print(e);
    }
  }
}
