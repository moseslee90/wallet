import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {
  final List<RadioModel> inputData;
  CustomRadio({this.inputData});
  @override
  createState() {
    return new CustomRadioState(inputData);
  }
}

class CustomRadioState extends State<CustomRadio> {
  List<RadioModel> inputData;
  CustomRadioState(this.inputData);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (inputData ?? true) {
      inputData = new List<RadioModel>();
      inputData.add(new RadioModel(isSelected: false, text: 'Expense'));
      inputData.add(new RadioModel(isSelected: false, text: 'Income'));
      inputData.add(new RadioModel(isSelected: false, text: 'Transfer', callback: (foo){
        print(foo);
      }, value: 'bar'));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [];

    for (var i = 0; i < inputData.length; i++) {
      buttons.add(FlatButton(
//          splashColor: Colors.blueAccent,
        onPressed: () {
          this.setState(() {
            inputData.forEach((element) => element.isSelected = false);
            inputData[i].isSelected = true;
          });
          if(inputData[i].callback != null) {
            print('call back is not null');
            inputData[i].callback(inputData[i].value);
          }
        },
        child: RadioItem(inputData[i]),
      ));
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ListItem"),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: buttons,
        ),
      ),
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
  final Function callback;

  RadioModel({this.isSelected, this.text, this.value, this.callback});
}
