import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './account.dart' as account;

class AccountsModel extends ChangeNotifier {
  /// Internal, private state of accounts
  Map<int, account.AccountModel> _accounts = {
    1: account.AccountModel(1, 2000, Colors.blue.shade400),
    2: account.AccountModel(2, 3000, Colors.green.shade500),
    3: account.AccountModel(3, 9000, Colors.indigo.shade400),
    4: account.AccountModel(4, 2500, Colors.teal.shade300),
    5: account.AccountModel(5, 3200, Colors.orange.shade300),
  };

  Map<int, account.AccountModel> get accounts => _accounts;

  account.AccountModel getAccountById(int id) => _accounts[id];

  int getAccountTotalById(int id) => getAccountById(id).total;

  void setAccountTotal(int id, int total) {
    _accounts[id].total = total;

    notifyListeners();
  }
}
