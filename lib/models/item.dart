import 'package:flutter/scheduler.dart';
import 'package:wallet/common/constants.dart' as constants;

class ItemModel {
  int id;
  String name;
  double amount;
  int accountId;
  int categoryId;
  int transactionType;
  int accountTransferToId;
  // TODO - add date field

  ItemModel({this.id, this.name, this.amount, this.accountId, this.categoryId, this.transactionType, this.accountTransferToId});

  ItemModel.fromMap(Map<String, dynamic> map) {
    id = map[constants.COLUMN_ID];
    name = map[constants.COLUMN_NAME];
    amount = map[constants.COLUMN_AMOUNT];
    accountId = map[constants.COLUMN_ACCOUNT_ID];
    categoryId = map[constants.COLUMN_CATEGORY_ID];
    transactionType = map[constants.COLUMN_TRANSACTION_TYPE];
    accountTransferToId = map[constants.COLUMN_ACCOUNT_TRANSFER_TO_ID];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      constants.COLUMN_NAME: name,
      constants.COLUMN_AMOUNT: amount,
      constants.COLUMN_ACCOUNT_ID: accountId,
      constants.COLUMN_CATEGORY_ID: categoryId,
      constants.COLUMN_TRANSACTION_TYPE: transactionType,
      constants.COLUMN_ACCOUNT_TRANSFER_TO_ID: accountTransferToId,
    };
    if (id != null) {
      map[constants.COLUMN_ID] = id;
    }
    return map;
  }

  String amountToString() {
    return amount.toString();
  }

  String transactionTypeToString() {
    return constants.TRANSACTION_TYPE[transactionType];
  }
}