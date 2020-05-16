import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './account.dart';
import 'package:wallet/common/constants.dart' as constants;
import 'package:wallet/database_helpers.dart' as databaseHelper;
import 'dart:math' as Math;

class AccountsModel {
  /// Internal, private state of accounts

  Map<int, AccountModel> accounts = {};
  
  AccountsModel(this.accounts);

  AccountModel getAccountById(int id) => accounts[id];

  addAccount(AccountModel account) {
    accounts[account.id] = account;
  }
}
