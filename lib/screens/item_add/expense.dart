import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/models/store.dart';
import '../../common/constants.dart';


class ExpenseForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final String name;
  final int amount;
  final int accountId;
  final int categoryId;
  final int transactionType = EXPENSE_INT;
  final Function onNameChanged;
  final Function onAmountChanged;
  final Function onAccountIdChanged;
  final Function onCategoryIdChanged;

  ExpenseForm(
      this.name,
      this.amount,
      this.accountId,
      this.categoryId,
      this.onNameChanged,
      this.onAmountChanged,
      this.onAccountIdChanged,
      this.onCategoryIdChanged);

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

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                        // Process data.
                        print(name);
                        print(
                            'amount: $amount, accountId: $accountId, categoryId: $categoryId, transactionId: $transactionType');
//                      store.addItem(name, amount, accountId, categoryId, transactionType);
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ])),
    );
  }
}
