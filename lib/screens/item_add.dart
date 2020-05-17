import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/scaffold.dart';
import 'package:wallet/models/store.dart';
import './item_add/form.dart';
import '../common/constants.dart';

class AddItemPage extends StatefulWidget {
  AddItemPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddItemPageState();
  }
}

class _AddItemPageState extends State<AddItemPage> {
  String name = '';
  int amount = 0;
  int accountId;
  int categoryId;
  int transactionType = EXPENSE_INT;

  onNameChanged(value) {
    name = value;
  }

  onAmountChanged(value) {
    amount = int.tryParse(value);
  }

  onAccountIdChanged(value) {
    this.setState(() {
      accountId = value;
    });
  }

  onCategoryIdChanged(value) {
    this.setState(() {
      categoryId = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyScaffold(
      body: ExpenseForm(name, amount, accountId, categoryId, onNameChanged,
          onAmountChanged, onAccountIdChanged, onCategoryIdChanged),
    );
  }
}
