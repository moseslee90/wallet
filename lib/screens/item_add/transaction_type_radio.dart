import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final List<RadioModel> inputData;

  CustomRadio({this.inputData});

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [];

    for (var i = 0; i < inputData.length; i++) {
      buttons.add(FlatButton(
//          splashColor: Colors.blueAccent,
        onPressed: () {
          if (inputData[i].callback != null) {
            print('call back is not null');
            inputData[i].callback();
          }
        },
        child: RadioItem(inputData[i]),
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: buttons,
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;

  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 45.0,
      width: 90.0,
      child: new Center(
        child: new Text(_item.text,
            style: new TextStyle(
                color: _item.isSelected ? Colors.white : Colors.black,
                //fontWeight: FontWeight.bold,
                fontSize: 18.0)),
      ),
      decoration: new BoxDecoration(
        color: _item.isSelected ? Colors.blueAccent : Colors.transparent,
        border: new Border.all(
            width: 1.0,
            color: _item.isSelected ? Colors.blueAccent : Colors.grey),
        borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String text;
  final dynamic value;
  Function callback;

  RadioModel({this.isSelected, this.text, this.value, this.callback});
}
