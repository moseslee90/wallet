import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/constants.dart';
import 'package:wallet/models/account.dart';
import 'package:wallet/models/category.dart';
import 'package:wallet/models/item.dart';
import 'package:wallet/models/store.dart';

const double firstRowFontSize = 16;
const FontWeight firstRowFontWeight = FontWeight.w500;
const double lightFontSize = 14;
const FontWeight lightFontWeight = FontWeight.w300;

class ItemsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var store = Provider.of<StoreModel>(context);
    Map<int, AccountModel> accounts = store.accounts.accounts;
    Map<int, CategoryModel> categories = store.categories.categories;
    List<ItemModel> items = store.items.items.values.toList();

    return Container(
      child: _ItemList(items, accounts, categories),
    );
  }
}

class _ItemList extends StatelessWidget {
  final List<ItemModel> items;
  final Map<int, AccountModel> accounts;
  final Map<int, CategoryModel> categories;

  _ItemList(this.items, this.accounts, this.categories);

  @override
  Widget build(BuildContext context) {
    List<Widget> itemList = [];

    for (var item in items) {
      final _accountName = accounts[item.accountId].name;
      final _categoryName = categories[item.categoryId].name;
      itemList.add(_ItemRow(item, _accountName, _categoryName));
    }

    return Column(
      children: itemList,
    );
  }
}

class _ItemRow extends StatelessWidget {
  final ItemModel item;
  final String accountName;
  final String categoryName;

  _ItemRow(this.item, this.accountName, this.categoryName);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final String _itemName = item.name;
    final String _amount = item.amount.toString();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _Icon(),
        _Center(categoryName, accountName, _itemName),
        _End(_amount),
      ],
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
  final TextStyle lightTextStyle = TextStyle(fontSize: lightFontSize, fontWeight: lightFontWeight);

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
                Text(categoryName, style: TextStyle(fontSize: firstRowFontSize, fontWeight: firstRowFontWeight)),
                Text(accountName, style: lightTextStyle),
                Text(itemName, style: lightTextStyle),
              ],
            ))));
  }
}

class _End extends StatelessWidget {
  final String amount;

  _End(this.amount);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 50,
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(amount, style: TextStyle(fontSize: firstRowFontSize, fontWeight: firstRowFontWeight, color: Colors.redAccent),),
        ],
      ),
    );
  }
}
