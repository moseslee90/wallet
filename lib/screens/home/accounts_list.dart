import 'package:flutter/material.dart';
import 'package:wallet/common/constants.dart' as constants;

class AccountsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          _Header(),
        ],
      )
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 6.0, top: 6.0, bottom: 10.0),
      child: Row(
        children: <Widget>[
          Text(constants.LIST_OF_ACCOUNTS),
          _SettingsIcon(),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}

class _SettingsIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        child: Center(
          child: Icon(Icons.settings, size: 20.0),
        ),
      ),
    );
  }
}
