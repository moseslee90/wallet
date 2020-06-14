import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/scaffold.dart';
import 'package:wallet/models/account.dart';
import 'package:wallet/models/item.dart';
import 'package:wallet/models/store.dart';
import 'package:wallet/screens/item_add/transaction_type_radio.dart';

import '../common/constants.dart';

class UpdateItemPageArguments {
  final ItemModel itemModel;

  UpdateItemPageArguments(this.itemModel);
}

class UpdateItemPageScreen extends StatelessWidget {
  static const routeName = PATH_ITEM_UPDATE;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final UpdateItemPageArguments args =
        ModalRoute.of(context).settings.arguments;

    return UpdateItemPage(itemModel: args.itemModel);
  }
}

class UpdateItemPage extends StatefulWidget {
  final ItemModel itemModel;

  UpdateItemPage({Key key, this.itemModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UpdateItemPageState(this.itemModel);
  }
}

class _UpdateItemPageState extends State<UpdateItemPage> {
  final _formKey = GlobalKey<FormState>();
  int id;
  String name;
  double amount;
  int accountId;
  int accountTransferToId;
  int categoryId;
  int transactionType;
  List<RadioModel> transactionRadios;

  _UpdateItemPageState(ItemModel itemModel) {
    this.id = itemModel.id;
    this.name = itemModel.name;
    this.amount = itemModel.amount;
    this.accountId = itemModel.accountId;
    this.accountTransferToId = itemModel.accountTransferToId;
    this.categoryId = itemModel.categoryId;
    this.transactionType = itemModel.transactionType;
  }

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
              isSelected: transInt == transactionType,
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
    transferAccounts.remove(accountId);
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

    return MyScaffold(
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                CustomRadio(inputData: transactionRadios),
                TextFormField(
                  initialValue: name,
                  decoration: const InputDecoration(
                    hintText: 'Enter Item Name',
                  ),
                  onChanged: onNameChanged,
                ),
                TextFormField(
                  initialValue: amount.toString(),
                  keyboardType: TextInputType.number,
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
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(right: 5.0),
                        child: RaisedButton(
                          onPressed: () {
                            // Validate will return true if the form is valid, or false if
                            // the form is invalid.
                            if (_formKey.currentState.validate()) {
                              store.updateItem(
                                  id,
                                  name,
                                  amount,
                                  accountId,
                                  categoryId,
                                  transactionType,
                                  accountTransferToId);
                              Navigator.pushNamed((context), PATH_HOME);
                            }
                          },
                          child: Text('Submit'),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          // Show Alert dialog to delete item
                          _showDeleteDialog(context, store, id);
                        },
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                ),
              ])),
        ),
      ),
    );
  }
}

Future<void> _showDeleteDialog(BuildContext ctx, StoreModel store, int id) async {
  return showDialog<void>(
      context: ctx,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text('Delete Item'),
            content: Text('Warning, delete is permanent!'),
            actions: <Widget>[
              FlatButton(
                  child: Text('Confirm'),
                  onPressed: () {
                    print('confirm clicked');
                    store.deleteItem(id);
                    Navigator.pushNamed(context, PATH_HOME);
                  }),
              FlatButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    print('cancel clicked');
                    Navigator.of(context).pop();
                  }),
            ]);
      });
}
