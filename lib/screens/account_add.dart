import 'package:flutter/material.dart';
import 'package:wallet/common/constants.dart';
import 'package:provider/provider.dart';
import 'package:wallet/models/store.dart';
import 'package:wallet/common/scaffold.dart';

class AddAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyScaffold(
      body: AccountInput(),
    );
  }
}

class _AccountInputState extends State<AccountInput> {
  final _formKey = GlobalKey<FormState>();
  static String defaultColor = 'Choose a Color';
  static String title = 'Add Account';
  String name = '';
  int color = 0;
  String colorName = defaultColor;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> dropdownColors = [
      DropdownMenuItem(
          value: defaultColor,
          child: Text(defaultColor, style: TextStyle(color: Colors.grey)))
    ];
    dropdownColors
        .addAll(<String>[BLUE_STRING, GREEN_STRING, INDIGO_STRING, TEAL_STRING, ORANGE_STRING].map((String value) {
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
                  name = value;
                },
              ),
              DropdownButtonFormField(
                value: colorName,
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
                  color = COLORS_MAP[value];
                  setState(() {
                    colorName = value;
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
                      print(name);
                      print(color);
                      Provider.of<StoreModel>(context, listen: false).addAccount(name, color);
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
