import './item.dart';
import '../common/constants.dart';

class ItemsModel {
  /// Internal, private state of items

  Map<int, ItemModel> items = {};

  ItemsModel(this.items);

  ItemModel getItemById(int id) => items[id];

  List<ItemModel> getForAccountId(int accountId) {
    List<ItemModel> result = [];
    items.forEach((_, value) {
      if (value.accountId == accountId) {
        result.add(value);
      }
    });
    return result;
  }

  double getTotalForAccount(int accountId) {
    double result = 0;
    items.forEach((_, item) {
      if (item.accountId == accountId) {
        switch (item.transactionType) {
          case EXPENSE_INT:
          case TRANSFER_INT:
            result -= item.amount;
            break;
          case INCOME_INT:
            result += item.amount;
            break;
        }
      } else if (item.accountTransferToId == accountId &&
          item.transactionType == TRANSFER_INT) {
        result += item.amount;
      }
    });
    return result;
  }

  addItem(ItemModel item) {
    items[item.id] = item;
  }

  updateItem(ItemModel item) {
    items[item.id] = item;
  }
}
