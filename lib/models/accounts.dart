import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './account.dart';
import 'package:wallet/common/constants.dart' as constants;
import 'package:wallet/database_helpers.dart' as databaseHelper;
import 'dart:math' as Math;

class AccountsModel {
  /// Internal, private state of accounts

  Map<int, AccountModel> _accounts = {};
  
  AccountsModel();

  Map<int, AccountModel> get accounts => _accounts;
  set accounts(Map<int, AccountModel> value) {
    this._accounts = value;
  }

  AccountModel getAccountById(int id) => _accounts[id];

  addAccount(AccountModel account) {
    _accounts[account.id] = account;
  }
}
