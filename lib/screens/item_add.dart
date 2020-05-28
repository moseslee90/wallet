import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/scaffold.dart';
import 'package:wallet/models/account.dart';
import 'package:wallet/models/store.dart';
import 'package:wallet/screens/item_add/transaction_type_radio.dart';
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
  final _formKey = GlobalKey<FormState>();
  String name = '';
  double amount = 0;
  int accountId;
  int accountTransferToId;
  int categoryId;
  int transactionType = EXPENSE_INT;
  List<RadioModel> transactionRadios;

  onNameChanged(value) {
    this.setState(() {
      name = value;
    });
  }

  onAmountChanged(value) {
    amount = double.tryParse(value);
  }

  onAccountIdChanged(value) {
    this.setState(() {
      if (value == accountTransferToId) {
        accountTransferToId = null;
      }
      accountId = value;
    });
  }

  onCategoryIdChanged(value) {
    this.setState(() {
      categoryId = value;
    });
  }

  onTransferAccountIdChanged(value) {
    this.setState(() {
      accountTransferToId = value;
    });
  }

  void initState() {
    super.initState();

    transactionRadios = TRANSACTION_TYPE
        .map((transInt, transStr) => MapEntry(
            transInt,
            RadioModel(
              isSelected: transInt == EXPENSE_INT,
              text: transStr,
              value: transInt,
            )))
        .values
        .toList();

    for (var i = 0; i < transactionRadios.length; i++) {
      transactionRadios[i].callback = () {
        this.setState(() {
          transactionRadios.forEach((element) => element.isSelected = false);
          transactionRadios[i].isSelected = true;
          transactionType = transactionRadios[i].value;
        });
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    StoreModel store = Provider.of<StoreModel>(context);

    List<DropdownMenuItem> dropdownAccountIds = store.accounts.accounts.values
        .map((_account) => DropdownMenuItem(
              value: _account.id,
              child: Text(_account.name),
            ))
        .toList();

    List<DropdownMenuItem> dropdownCategoryIds =
        store.categories.categories.values
            .map((_category) => DropdownMenuItem(
                  value: _category.id,
                  child: Text(_category.name),
                ))
            .toList();
    Map<int, AccountModel> transferAccounts = Map.from(store.accounts.accounts);
    print(transferAccounts);
    transferAccounts.remove(accountId);
    print(transferAccounts);
    List<DropdownMenuItem> dropdownTransferAccountIds = transferAccounts.values
        .map((_account) => DropdownMenuItem(
              value: _account.id,
              child: Text(_account.name),
            ))
        .toList();
    Widget transferToAccountDropdown = transactionType == TRANSFER_INT
        ? DropdownButtonFormField(
            value: accountTransferToId,
            decoration: const InputDecoration(
              hintText: 'Select Transfer Account',
            ),
            validator: (value) {
              if (value == null) {
                return 'Please Choose an Account';
              }
              return null;
            },
            items: dropdownTransferAccountIds,
            onChanged: onTransferAccountIdChanged,
          )
        : SizedBox.shrink();

    // TODO: implement build
    return MyScaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              CustomRadio(inputData: transactionRadios),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter Item Name',
                ),
                onChanged: onNameChanged,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter Item Amount',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  } else if (double.tryParse(value) == null) {
                    return 'Please enter a number';
                  }
                  return null;
                },
                onChanged: onAmountChanged,
              ),
              DropdownButtonFormField(
                value: accountId,
                decoration: const InputDecoration(
                  hintText: 'Select Account',
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please Choose an Account';
                  }
                  return null;
                },
                items: dropdownAccountIds,
                onChanged: onAccountIdChanged,
              ),
              transferToAccountDropdown,
              DropdownButtonFormField(
                value: categoryId,
                decoration: const InputDecoration(
                  hintText: 'Select Category',
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please Choose a Category';
                  }
                  return null;
                },
                items: dropdownCategoryIds,
                onChanged: onCategoryIdChanged,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState.validate()) {
                      print('name: $name');
                      print(
                          'amount: $amount, accountId: $accountId, categoryId: $categoryId, transactionId: $transactionType, transferAccount: $accountTransferToId');
                      store.addItem(name, amount, accountId, categoryId, transactionType, accountTransferToId);
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ])),
      ),
    );
  }
}
