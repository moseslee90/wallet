// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/constants.dart' as constants;
import 'package:wallet/screens/home.dart' as homePage;
import 'package:wallet/screens/add_account.dart' as addAccount;
import 'package:wallet/models/store.dart' as storeModel;
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ChangeNotifierProvider<storeModel.StoreModel> storeProvider =
        ChangeNotifierProvider(create: (context) => storeModel.StoreModel());
    print(storeProvider);
    return MultiProvider(
      providers: [
        storeProvider,
      ],
      child: MaterialApp(
        title: constants.WALLET,
        initialRoute: '/',
        theme: ThemeData(
            textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        )),
        routes: {
          '/': (context) => homePage.HomePage(),
          '/add_account': (context) => addAccount.AddAccountPage(),
        },
      ),
    );
  }
}
