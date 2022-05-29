import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

import '../Model/todo.dart';

class TodoDb {
  // factory TodoDb() {
  //
  //   return _singleton;
  // }

  final store = intMapStoreFactory.store();
  Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      await _openDb(null).then((db) {
        _database = db;
      });
    }
    return _database;
  }

  Future _openDb(Directory? directory) async {
    if(directory==null) {
      if(kIsWeb){
        print("run on web");
        DatabaseFactory dbFactoryWeb = databaseFactoryWeb;
        // final docsPath = await getApplicationDocumentsDirectory();
        final dbPath = join('todos.db');
        final db = await dbFactoryWeb.openDatabase(dbPath);
        return db;
      } else {
        DatabaseFactory dbFactory = databaseFactoryIo;
        final docsPath = await getApplicationDocumentsDirectory();
        final dbPath = join(docsPath.path, 'todos.db');
        final db = await dbFactory.openDatabase(dbPath);
        return db;
      }
    } else {
      DatabaseFactory dbFactory = databaseFactoryIo;
      final docsPath = directory;
      final dbPath = join(docsPath.path, 'todos.db');
      final db = await dbFactory.openDatabase(dbPath);
      _database = db;
      return db;
    }
  }

  Future insertTodo(Todo todo) async {
    await store.add(_database!, todo.toMap());
  }

  Future updateTodo(Todo todo) async {
    //Finder is a helper for searching a given store
    final finder = Finder(filter: Filter.byKey(todo.id));
    await store.update(_database!, todo.toMap(), finder: finder);
  }

  Future deleteTodo(Todo todo) async {
    final finder = Finder(filter: Filter.byKey(todo.id));
    await store.delete(_database!, finder: finder);
  }

  Future deleteAll() async {
    // Clear all records from the store
    await store.delete(_database!);
  }

  Future<List<Todo>> getTodos(Directory? directory) async {
    directory == null ? await database : await _openDb(directory);
    final finder = Finder(sortOrders: [
      SortOrder('priority'),
      SortOrder('id'),
    ]);
    final todosSnapshot = await store.find(_database!, finder: finder);
    return todosSnapshot.map((snapshot){
      final todo = Todo.fromMap(snapshot.value);
      //the id is automatically generated
      todo.id = snapshot.key;
      return todo;
    }).toList();


  }

  // //this need to be singleton
  // static final TodoDb _singleton = TodoDb._internal();
  // //private internal constructor
  // TodoDb._internal();
}