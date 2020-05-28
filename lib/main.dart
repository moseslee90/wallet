// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'common/constants.dart';
import 'models/store.dart';
import 'screens/home.dart';
import 'screens/account_add.dart';
import 'screens/account_settings.dart';
import 'screens/category_add.dart';
import 'screens/item_add.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ChangeNotifierProvider<StoreModel> storeProvider =
        ChangeNotifierProvider(create: (context) => StoreModel());
    print(storeProvider);
    return MultiProvider(
      providers: [
        storeProvider,
      ],
      child: MaterialApp(
        title: WALLET,
        initialRoute: '/',
        routes: {
          PATH_HOME: (context) => HomePage(),
          PATH_ACCOUNT_ADD: (context) => AddAccountPage(),
          PATH_ACCOUNT_SETTINGS: (context) => AccountSettingsPage(),
          PATH_CATEGORY_ADD: (context) => AddCategoryPage(),
          PATH_ITEM_ADD: (context) => AddItemPage(),
        },
      ),
    );
  }
}
