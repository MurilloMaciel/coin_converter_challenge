import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

const DB_PATH = "com.murillo.coinconverter.path.db";

class AppDatabase {

  static final AppDatabase _singleton = AppDatabase._();

  static AppDatabase get instance => _singleton;
  Completer<Database> _dbOpenCompleter;
  AppDatabase._();

  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDatabase();
    }
    return _dbOpenCompleter.future;
  }

  Future _openDatabase() async {
    try {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      final dbPath = join(appDocumentDir.path, DB_PATH);
      final database = await databaseFactoryIo.openDatabase(dbPath);
      _dbOpenCompleter.complete(database);
    } catch (error) {
      print("open database error: ${error.toString()}");
    }
  }
}