import 'package:flutter/foundation.dart';
import './account.dart' as account;

class AccountsModel extends ChangeNotifier {
  /// Internal, private state of accounts
  Map<int, account.AccountModel> _accounts = {
    1: account.AccountModel(1, 2000),
  };

  Map<int, account.AccountModel> get accounts => _accounts;

  account.AccountModel getAccountById(int id) => _accounts[id];

  int getAccountTotalById(int id) => getAccountById(id).total;

  void setAccountTotal(int id, int total) {
    _accounts[id] = account.AccountModel(id, total);

    notifyListeners();
  }
}
