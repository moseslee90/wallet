import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final List<RadioModel> inputData;
  final AutoSizeGroup autoSizeGroup;

  CustomRadio({this.inputData, this.autoSizeGroup});

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [];

    for (var i = 0; i < inputData.length; i++) {
      buttons
          .add(RadioItem(inputData[i], inputData[i].callback, autoSizeGroup));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: buttons,
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel item;
  final Function callback;
  final AutoSizeGroup autoSizeGroup;

  RadioItem(this.item, this.callback, this.autoSizeGroup);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Expanded(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: screenWidth < screenHeight ? screenWidth / 8 : screenHeight / 16,
      decoration: BoxDecoration(
        color: item.isSelected ? Colors.blueAccent : Colors.transparent,
        border: Border.all(
            width: 1.0,
            color: item.isSelected ? Colors.blueAccent : Colors.grey),
        borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
      ),
      child: FlatButton(
//          splashColor: Colors.blueAccent,
        onPressed: () {
          if (this.callback != null) {
            this.callback();
          }
        },
        child: AutoSizeText(
          item.text,
          style: TextStyle(
            color: item.isSelected ? Colors.white : Colors.black,
            fontSize: 30,
          ),
          maxLines: 1,
          group: autoSizeGroup,
        ),
      ),
    ));
  }
}

class RadioModel {
  bool isSelected;
  final String text;
  final dynamic value;
  Function callback;

  RadioModel({this.isSelected, this.text, this.value, this.callback});
}
