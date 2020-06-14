import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/constants.dart';
import 'package:wallet/models/accounts.dart';
import 'package:wallet/models/categories.dart';
import 'package:wallet/models/item.dart';
import 'package:wallet/models/store.dart';
import 'package:wallet/screens/item_update.dart';

const double firstRowFontSize = 16;
const FontWeight firstRowFontWeight = FontWeight.w500;
const double lightFontSize = 14;
const FontWeight lightFontWeight = FontWeight.w300;

class ItemsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var store = Provider.of<StoreModel>(context);
    AccountsModel accounts = store.accounts;
    CategoriesModel categories = store.categories;
    List<ItemModel> items = store.items.items.values.toList();

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Container(
        padding: EdgeInsets.only(left: 4, top: 10, bottom: 10, right: 7),
        child: _ItemList(items, accounts, categories),
      ),
    );
  }
}

class _ItemList extends StatelessWidget {
  final List<ItemModel> items;
  final AccountsModel accounts;
  final CategoriesModel categories;

  _ItemList(this.items, this.accounts, this.categories);

  @override
  Widget build(BuildContext context) {
    List<Widget> itemList = [];
    for (var item in items) {
      // initialise amount as negative, assume is expense
      // or a transfer out
      double amount = -item.amount;
      String accountName = accounts.getName(item.accountId);
      final categoryName = categories.getName(item.categoryId);
      // if item is INCOME change amount to positive
      if (item.transactionType == INCOME_INT) {
        amount = item.amount;
      }
      itemList.add(_ItemRow(item, amount, accountName, categoryName));
      // if item accountTransferToId is not null, add row
      // to show amount being transferred into account
      if (item.accountTransferToId != null) {
        amount = item.amount;
        accountName = accounts.getName(item.accountTransferToId);
        itemList.add(_ItemRow(item, amount, accountName, categoryName));
      }
    }
    final ScrollController scrollController =
        ScrollController(initialScrollOffset: 0);

    return Container(
        height: MediaQuery.of(context).size.width * 4 / 5,
        child: Scrollbar(
            controller: scrollController,
            isAlwaysShown: true,
            child: ListView.builder(
                controller: scrollController,
                padding: EdgeInsets.only(right: 10),
                itemCount: itemList.length,
                itemBuilder: (context, int index) {
                  return itemList[index];
                })));
  }
}

class _ItemRow extends StatelessWidget {
  final ItemModel itemModel;
  final double amount;
  final String accountName;
  final String categoryName;

  _ItemRow(this.itemModel, this.amount, this.accountName, this.categoryName);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        print('item tapped');
        print(itemModel);
        Navigator.pushNamed(context, UpdateItemPageScreen.routeName,
            arguments: UpdateItemPageArguments(itemModel));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Icon(),
          _Center(categoryName, accountName, itemModel.name),
          _End(amount),
        ],
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  // TODO - _Icon should have a constructor that takes in an IconID that category uses
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Icon(
        Icons.android,
        color: Colors.green,
        size: 50.0,
      ),
    );
  }
}

class _Center extends StatelessWidget {
  final String categoryName;
  final String accountName;
  final String itemName;
  final TextStyle lightTextStyle =
      TextStyle(fontSize: lightFontSize, fontWeight: lightFontWeight);

  _Center(this.categoryName, this.accountName, this.itemName);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
        child: (Container(
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(categoryName,
                    style: TextStyle(
                        fontSize: firstRowFontSize,
                        fontWeight: firstRowFontWeight)),
                Text(accountName, style: lightTextStyle),
                Text(itemName, style: lightTextStyle),
              ],
            ))));
  }
}

class _End extends StatelessWidget {
  final double amount;

  _End(this.amount);

  @override
  Widget build(BuildContext context) {
    String amountString = amount.toString();
    Color fontColor = Colors.redAccent;
    if (amount > 0) {
      fontColor = Colors.greenAccent;
    }
    return Container(
      width: 60,
      height: 50,
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(amountString,
              style: TextStyle(
                  fontSize: firstRowFontSize,
                  fontWeight: firstRowFontWeight,
                  color: fontColor)),
        ],
      ),
    );
  }
}
