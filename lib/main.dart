// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/constants.dart';
import 'package:wallet/screens/home.dart';
import 'package:wallet/screens/account_add.dart';
import 'package:wallet/screens/account_settings.dart';
import 'package:wallet/models/store.dart';
import 'package:google_fonts/google_fonts.dart';

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
        theme: ThemeData(
            textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        )),
        routes: {
          PATH_HOME: (context) => HomePage(),
          PATH_ACCOUNT_ADD: (context) => AddAccountPage(),
          PATH_ACCOUNT_SETTINGS: (context) => AccountSettingsPage(),
        },
      ),
    );
  }
}
