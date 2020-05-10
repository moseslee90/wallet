import 'package:flutter/material.dart';
import 'package:wallet/common/constants.dart';

class HomeDrawer extends Drawer {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30),
            height: 100,
            color: Colors.green,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 15),
                  child: Icon(Icons.person_outline),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Name', style: TextStyle(color: Colors.white)),
                        Text('My Wallet',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text(CATEGORIES),
            onTap: () => Navigator.pushNamed(context, PATH_CATEGORY_ADD),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
