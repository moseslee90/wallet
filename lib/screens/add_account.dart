import 'package:flutter/material.dart';
import 'package:wallet/common/constants.dart';
import 'package:provider/provider.dart';
import 'package:wallet/models/store.dart';
import 'package:wallet/common/appbar.dart' as myAppBar;

class AddAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: myAppBar.MyAppBar(),
      body: AccountInput(),
    );
  }
}

class _AccountInputState extends State<AccountInput> {
  final _formKey = GlobalKey<FormState>();
  static String defaultColor = 'Choose a Color';
  static String title = 'Add Account';
  String accountName = '';
  int accountColor = 0;
  String accountColorName = defaultColor;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> dropdownColors = [
      DropdownMenuItem(
          value: defaultColor,
          child: Text(defaultColor, style: TextStyle(color: Colors.grey)))
    ];
    dropdownColors
        .addAll(<String>[blue, green, indigo, teal, orange].map((String value) {
      return DropdownMenuItem(
        value: value,
        child: Text(value),
      );
    }));
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  title,

              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter Account Name',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (value) {
                  accountName = value;
                },
              ),
              DropdownButtonFormField(
                value: accountColorName,
                decoration: const InputDecoration(
                  hintText: 'Select Color',
                ),
                validator: (value) {
                  if (value == defaultColor) {
                    return 'Please Choose a Color';
                  }
                  return null;
                },
                items: dropdownColors,
                onChanged: (value) {
                  accountColor = colors[value];
                  setState(() {
                    accountColorName = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState.validate()) {
                      // Process data.
                      print(accountName);
                      print(accountColor);
                      Provider.of<StoreModel>(context, listen: false).addAccount(accountName, accountColor);
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ]));
  }
}

class AccountInput extends StatefulWidget {
  AccountInput({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AccountInputState();
  }
}
