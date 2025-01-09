import 'dart:async';
import 'package:flutter_application_1/models/subscription_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'subscriptions.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE subscriptions (
        id TEXT ,
        user_id TEXT,
        account_number TEXT,
        account_type_id TEXT,
        bank_name TEXT,
        branch_name TEXT,
        branch_code TEXT,
        account_holder_name TEXT,
        currency_id TEXT,
        balance TEXT,
        cvv TEXT,
        card_number TEXT,
        card_creation_date TEXT,
        card_expiry_date TEXT,
        phone_number TEXT,
        email_address TEXT,
        account_status_id TEXT,
        created_on TEXT,
        last_modified_on TEXT,
        total_updates TEXT,
        favourite TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE updatedSubscriptions (
        id TEXT ,
        user_id TEXT,
        account_number TEXT,
        account_type_id TEXT,
        bank_name TEXT,
        branch_name TEXT,
        branch_code TEXT,
        account_holder_name TEXT,
        currency_id TEXT,
        balance TEXT,
        cvv TEXT,
        card_number TEXT,
        card_creation_date TEXT,
        card_expiry_date TEXT,
        phone_number TEXT,
        email_address TEXT,
        account_status_id TEXT,
        created_on TEXT,
        last_modified_on TEXT,
        total_updates TEXT,
        favourite TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE deletedSubscriptions (
        id TEXT ,
        user_id TEXT,
        account_number TEXT,
        account_type_id TEXT,
        bank_name TEXT,
        branch_name TEXT,
        branch_code TEXT,
        account_holder_name TEXT,
        currency_id TEXT,
        balance TEXT,
        cvv TEXT,
        card_number TEXT,
        card_creation_date TEXT,
        card_expiry_date TEXT,
        phone_number TEXT,
        email_address TEXT,
        account_status_id TEXT,
        created_on TEXT,
        last_modified_on TEXT,
        total_updates TEXT,
        favourite TEXT
      )
    ''');

  }

  /// Insert a subscription
  Future<int> insertSubscription(Data data) async {
    final db = await database;
    return await db.insert('subscriptions', data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// Get all subscriptions
  Future<List<Data>> getAllSubscriptions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('subscriptions');

    return List.generate(maps.length, (i) {
      return Data.fromJson(maps[i]);
    });
  }

  /// Get a subscription by ID
  Future<Data?> getSubscriptionById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'subscriptions',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Data.fromJson(maps.first);
    }
    return null;
  }

  /// Update a subscription
  Future<int> updateSubscription(Data data) async {
    final db = await database;
    return await db.update(
      'subscriptions',
      data.toJson(),
      where: 'id = ?',
      whereArgs: [data.id],
    );
  }

  /// Delete a subscription
  Future<int> deleteSubscription(String id) async {
    final db = await database;
    return await db.delete(
      'subscriptions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Delete all subscriptions
  Future<int> deleteAllSubscriptions() async {
    final db = await database;
    return await db.delete('subscriptions');
  }

  //Method to close Database
  Future close()async{
    var db = await database;
    db.close();
  }


  /*
  These functions are for deletedSubscription table
  */

   /// Insert a deleted subscription
  Future<int> insertDeletedSubscription(Data data) async {
    final db = await database;
    return await db.insert('deletedSubscriptions', data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  
  /// Get deleted Subscription 
  Future<List<Data>> getAllDeletedSubscriptions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('deletedSubscriptions');

    return List.generate(maps.length, (i) {
      return Data.fromJson(maps[i]);
    });
  }

  /// Delete All rows in deletedSubscription
  Future<int> deleteAllDeletedSubscriptions() async {
    final db = await database;
    return await db.delete('deletedSubscriptions');
  }


   /*
  These functions are for updatedSubscription table
  */

   /// Insert a updated subscription
  Future<int> insertUpdatedSubscription(Data data) async {
    final db = await database;
    return await db.insert('updatedSubscriptions', data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }


  /// Get deleted Subscription 
  Future<List<Data>> getAllUpdatedSubscriptions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('updatedSubscriptions');

    return List.generate(maps.length, (i) {
      return Data.fromJson(maps[i]);
    });
  }

   /// Delete All rows in deletedSubscription
  Future<int> deleteAllUpdatedSubscriptions() async {
    final db = await database;
    return await db.delete('updatedSubscriptions');
  }
}
