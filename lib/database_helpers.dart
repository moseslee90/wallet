import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallet/common/constants.dart' as constants;
import 'package:wallet/models/account.dart' as accountModel;
import 'package:wallet/models/accounts.dart' as accountsModel;

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
              CREATE TABLE ${constants.tableAccounts} (
                ${constants.columnId} INTEGER PRIMARY KEY,
                ${constants.columnTotal} INTEGER NOT NULL,
                ${constants.columnColor} INTEGER NOT NULL
              )
              ''');
  }

  // Database helper methods:

  Future<int> insert(accountModel.AccountModel account) async {
    Database db = await database;
    int id = await db.insert(constants.tableAccounts, account.toMap());
    return id;
  }

  Future<accountModel.AccountModel> queryAccount(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(constants.tableAccounts,
        columns: [constants.columnId, constants.columnTotal, constants.columnColor],
        where: '${constants.columnId} = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return accountModel.AccountModel.fromMap(maps.first);
    }
    return null;
  }

  Future<Map<int, accountModel.AccountModel>> queryAccounts() async {
    Database db = await database;
    Map<int, accountModel.AccountModel> accountModelMap = {};
    List<Map> maps = await db.query(constants.tableAccounts,
        columns: [constants.columnId, constants.columnTotal, constants.columnColor]);
    maps.forEach((map) {
      accountModel.AccountModel account = accountModel.AccountModel.fromMap(map);
      accountModelMap[account.id] = account;
    });
    if (maps.length > 0) {
      return accountModelMap;
    }
    return {};
  }

// TODO: queryAllWords()
// TODO: delete(int id)
// TODO: update(Word word)
}
