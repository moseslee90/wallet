import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallet/common/constants.dart' as constants;
import 'package:wallet/models/account.dart';
import 'package:wallet/models/accounts.dart';
import 'package:wallet/models/category.dart';
import 'package:wallet/models/items.dart';
import 'package:wallet/models/item.dart';
import 'package:wallet/models/store.dart';

// singleton class to manage the database
class DatabaseHelper {

  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

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
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE IF NOT EXISTS ${constants.TABLE_ACCOUNTS} (
                ${constants.COLUMN_ID} INTEGER PRIMARY KEY,
                ${constants.COLUMN_NAME} TEXT NOT NULL,
                ${constants.COLUMN_COLOR} INTEGER NOT NULL
              );
              ''');
    await db.execute('''
              CREATE TABLE IF NOT EXISTS ${constants.TABLE_CATEGORY} (
                ${constants.COLUMN_NAME} TINYTEXT NOT NULL
              );
              ''');
    await db.execute('''
              CREATE TABLE IF NOT EXISTS ${constants.TABLE_ITEMS} (
                ${constants.COLUMN_ID} INTEGER PRIMARY KEY,
                ${constants.COLUMN_NAME} TEXT NOT NULL,
                ${constants.COLUMN_AMOUNT} INTEGER NOT NULL,
                ${constants.COLUMN_TRANSACTION_TYPE} BOOLEAN NOT NULL,
                ${constants.COLUMN_ACCOUNT_ID} INTEGER NOT NULL,
                ${constants.COLUMN_CATEGORY_ID} INTEGER NOT NULL
              );
              ''');
  }

  // Database helper methods:

  Future<int> insertAccount(AccountModel account) async {
    Database db = await database;
    int id = await db.insert(constants.TABLE_ACCOUNTS, account.toMap());
    return id;
  }

  Future<AccountModel> queryAccount(int id) async {
    Database db = await database;
    List<Map> accountMaps = await db.query(constants.TABLE_ACCOUNTS,
        columns: [constants.COLUMN_ID, constants.COLUMN_NAME, constants.COLUMN_COLOR],
        where: '${constants.COLUMN_ID} = ?',
        whereArgs: [id]);
    if (accountMaps.length > 0) {
      return AccountModel.fromMap(accountMaps.first);
    }
    return null;
  }

  Future<Map<int, AccountModel>> queryAccounts() async {
    Database db = await database;
    Map<int, AccountModel> accountModelMap = {};
    List<Map> maps = await db.query(constants.TABLE_ACCOUNTS,
        columns: [constants.COLUMN_ID, constants.COLUMN_NAME, constants.COLUMN_COLOR]);
    maps.forEach((map) {
      AccountModel account = AccountModel.fromMap(map);
      accountModelMap[account.id] = account;
    });
    if (maps.length > 0) {
      return accountModelMap;
    }
    return {};
  }

  Future<int> insertItem(ItemModel item) async {
    Database db = await database;
    int id = await db.insert(constants.TABLE_ITEMS, item.toMap());
    return id;
  }

  Future<Map<int, ItemModel>> queryItems() async {
    Database db = await database;
    Map<int, ItemModel> itemModelMap = {};
    List<Map> maps = await db.query(constants.TABLE_ITEMS,
        columns: [constants.COLUMN_ID, constants.COLUMN_NAME, constants.COLUMN_AMOUNT, constants.COLUMN_ACCOUNT_ID, constants.COLUMN_CATEGORY_ID, constants.COLUMN_TRANSACTION_TYPE]);
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
    int id = await db.insert(constants.TABLE_CATEGORY, item.toMap());
    return id;
  }

  Future<Map<int, ItemModel>> queryCategory() async {
    Database db = await database;
    Map<int, ItemModel> itemModelMap = {};
    List<Map> maps = await db.query(constants.TABLE_CATEGORY,
        columns: [constants.COLUMN_ID, constants.COLUMN_NAME]);
    maps.forEach((map) {
      ItemModel item = ItemModel.fromMap(map);
      itemModelMap[item.id] = item;
    });
    if (maps.length > 0) {
      return itemModelMap;
    }
    return {};
  }

// TODO: queryAllWords()
// TODO: delete(int id)
// TODO: update(Word word)
}
