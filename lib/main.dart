// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/constants.dart' as constants;
import 'package:wallet/screens/home.dart' as homePage;
import 'package:wallet/models/store.dart' as storeModel;

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
        routes: {
          '/': (context) => homePage.HomePage(),
        },
      ),
    );
  }
}
