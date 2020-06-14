import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallet/common/constants.dart';
import 'package:wallet/models/account.dart';
import 'package:wallet/models/category.dart';
import 'package:wallet/models/item.dart';

// singleton class to manage the database
class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";

  // Increment this version when you need to change the schema.
  static final _databaseVersion = 2;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.transaction((txn) async {
      await txn.execute('''
              CREATE TABLE IF NOT EXISTS $TABLE_ACCOUNTS (
                $COLUMN_ID INTEGER PRIMARY KEY,
                $COLUMN_NAME TEXT NOT NULL,
                $COLUMN_COLOR INTEGER NOT NULL,
                $COLUMN_POSITION INTEGER
              );
              ''');
      await txn.execute('''
              CREATE TABLE IF NOT EXISTS $TABLE_CATEGORY (
                $COLUMN_ID INTEGER PRIMARY KEY,
                $COLUMN_NAME TEXT NOT NULL,
                $COLUMN_COLOR INTEGER NOT NULL
              );
              ''');
      await txn.execute('''
              CREATE TABLE IF NOT EXISTS $TABLE_ITEMS (
                $COLUMN_ID INTEGER PRIMARY KEY,
                $COLUMN_NAME TEXT,
                $COLUMN_AMOUNT FLOAT NOT NULL,
                $COLUMN_TRANSACTION_TYPE BOOLEAN NOT NULL,
                $COLUMN_ACCOUNT_ID INTEGER NOT NULL,
                $COLUMN_CATEGORY_ID INTEGER,
                $COLUMN_ACCOUNT_TRANSFER_TO_ID INTEGER
              );
              ''');
    });
  }

  // Database helper methods:

  Future<int> insertAccount(AccountModel account) async {
    Database db = await database;
    int id = await db.insert(TABLE_ACCOUNTS, account.toMap());
    return id;
  }

  Future<AccountModel> queryAccount(int id) async {
    Database db = await database;
    List<Map> accountMaps = await db.query(TABLE_ACCOUNTS,
        columns: [COLUMN_ID, COLUMN_NAME, COLUMN_COLOR, COLUMN_POSITION],
        where: '$COLUMN_ID = ?',
        whereArgs: [id]);
    if (accountMaps.length > 0) {
      return AccountModel.fromMap(accountMaps.first);
    }
    return null;
  }

  Future<Map<int, AccountModel>> queryAccounts() async {
    Database db = await database;
    Map<int, AccountModel> accountModelMap = {};
    List<Map> maps = await db.query(TABLE_ACCOUNTS,
        columns: [COLUMN_ID, COLUMN_NAME, COLUMN_COLOR, COLUMN_POSITION]);
    maps.forEach((map) {
      AccountModel account = AccountModel.fromMap(map);
      accountModelMap[account.id] = account;
    });
    if (maps.length > 0) {
      return accountModelMap;
    }
    return {};
  }

  Future<int> updateAccount(AccountModel account) async {
    Database db = await database;
    return await db.update(TABLE_ACCOUNTS, account.toMap(),
        where: '$COLUMN_ID = ?', whereArgs: [account.id]);
  }

  Future<int> insertItem(ItemModel item) async {
    Database db = await database;
    int id = await db.insert(TABLE_ITEMS, item.toMap());
    return id;
  }

  Future<int> updateItem(ItemModel item) async {
    Database db = await database;
    int id = await db.update(TABLE_ITEMS, item.toMap(),
      where: '$COLUMN_ID = ?', whereArgs: [item.id]);
    return id;
  }

  Future<Map<int, ItemModel>> queryItems() async {
    Database db = await database;
    Map<int, ItemModel> itemModelMap = {};
    List<Map> maps = await db.query(TABLE_ITEMS, columns: [
      COLUMN_ID,
      COLUMN_NAME,
      COLUMN_AMOUNT,
      COLUMN_ACCOUNT_ID,
      COLUMN_CATEGORY_ID,
      COLUMN_TRANSACTION_TYPE,
      COLUMN_ACCOUNT_TRANSFER_TO_ID
    ]);
    maps.forEach((map) {
      ItemModel item = ItemModel.fromMap(map);
      itemModelMap[item.id] = item;
    });
    if (maps.length > 0) {
      return itemModelMap;
    }
    return {};
  }

  Future<int> insertCategory(CategoryModel item) async {
    Database db = await database;
    int id = await db.insert(TABLE_CATEGORY, item.toMap());
    return id;
  }

  Future<Map<int, ItemModel>> queryCategory() async {
    Database db = await database;
    Map<int, ItemModel> itemModelMap = {};
    List<Map> maps =
        await db.query(TABLE_CATEGORY, columns: [COLUMN_ID, COLUMN_NAME, COLUMN_COLOR]);
    maps.forEach((map) {
      ItemModel item = ItemModel.fromMap(map);
      itemModelMap[item.id] = item;
    });
    if (maps.length > 0) {
      return itemModelMap;
    }
    return {};
  }

  Future<Map<int, CategoryModel>> queryCategories() async {
    Database db = await database;
    Map<int, CategoryModel> categoryModelMap = {};
    List<Map> maps = await db.query(TABLE_CATEGORY, columns: [
      COLUMN_ID,
      COLUMN_NAME,
      COLUMN_COLOR
    ]);
    maps.forEach((map) {
      CategoryModel category = CategoryModel.fromMap(map);
      categoryModelMap[category.id] = category;
    });
    if (maps.length > 0) {
      return categoryModelMap;
    }
    return {};
  }
}
