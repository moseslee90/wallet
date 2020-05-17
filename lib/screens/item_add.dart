import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/scaffold.dart';
import 'package:wallet/models/store.dart';
import 'package:wallet/screens/item_add/transaction_type_radio.dart';
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
  List<RadioModel> transactionRadios;

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

  void initState() {
    super.initState();

    transactionRadios = TRANSACTION_TYPE
        .map((transInt, transStr) =>
        MapEntry(transInt, RadioModel(
          isSelected: false,
          text: transStr,
          value: transInt,
        )))
        .values
        .toList();

    for (var i = 0; i < transactionRadios.length; i++) {
      transactionRadios[i].callback = () {
        this.setState((){
          transactionRadios.forEach((element) => element.isSelected = false);
          transactionRadios[i].isSelected = true;
        });
      };
    }
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return MyScaffold(
      body: ExpenseForm(
          name: name,
          amount: amount,
          accountId: accountId,
          categoryId: categoryId,
          transactionTypes: transactionRadios,
          onNameChanged: onNameChanged,
          onAmountChanged: onAmountChanged,
          onAccountIdChanged: onAccountIdChanged,
          onCategoryIdChanged: onCategoryIdChanged),
    );
  }
}
