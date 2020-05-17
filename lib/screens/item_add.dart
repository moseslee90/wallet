import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/scaffold.dart';
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
  int amount = 0;
  int accountId;
  int categoryId;
  int transactionType = EXPENSE_INT;
  List<RadioModel> transactionRadios;

  onNameChanged(value) {
    this.setState(() {
      name = value;
    });
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

  onSubmit() {
    print('name: $name');
    print(
        'amount: $amount, accountId: $accountId, categoryId: $categoryId, transactionId: $transactionType');
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
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: onNameChanged,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter Item Amount',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  } else if (int.tryParse(value) == null) {
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
                      onSubmit();
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
