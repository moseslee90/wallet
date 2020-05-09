import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/models/store.dart';

class _CategoryFormState extends State<CategoryForm> {
  final _formKey = GlobalKey<FormState>();
  String categoryName = '';

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter Category Name',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (value) {
                  categoryName = value;
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
                      print(categoryName);
                      Provider.of<StoreModel>(context, listen: false)
                          .addCategory(categoryName);
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ]));
  }
}

class CategoryForm extends StatefulWidget {
  CategoryForm({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CategoryFormState();
  }
}
