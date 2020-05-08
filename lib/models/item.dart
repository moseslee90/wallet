import 'package:wallet/common/constants.dart' as constants;

class ItemModel {
  int id;
  String name;
  int amount;
  int accountId;
  int categoryId;
  int transactionType;

  ItemModel({this.id, this.name, this.amount, this.accountId, this.categoryId, this.transactionType});

  ItemModel.fromMap(Map<String, dynamic> map) {
    id = map[constants.columnId];
    amount = map[constants.columnAmount];
    accountId = map[constants.columnAccountId];
    categoryId = map[constants.columnCategoryId];
    transactionType = map[constants.columnTransactionType];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      constants.columnAmount: amount,
      constants.columnAccountId: accountId,
      constants.columnCategoryId: categoryId,
      constants.columnTransactionType: transactionType,
    };
    if (id != null) {
      map[constants.columnId] = id;
    }
    return map;
  }

  String amountToString() {
    return amount.toString();
  }

  String transactionTypeToString() {
    return constants.transactionType[transactionType];
  }
}