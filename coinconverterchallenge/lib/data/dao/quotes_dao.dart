import 'package:coinconverterchallenge/core/db/AppDatabase.dart';
import 'package:coinconverterchallenge/core/db/access_error.dart';
import 'package:coinconverterchallenge/data/model/quotes_data.dart';
import 'package:dartz/dartz.dart';
import 'package:sembast/sembast.dart';

class QuotesDao {

  static const String _folderName = "quotes_path";
  final _folder = intMapStoreFactory.store(_folderName);

  Future<Database> get  _db  async => await AppDatabase.instance.database;

  Future insert(QuotesData quote) async {
    try {
      await  _folder.add(await _db, quote.toJson());
    } catch (error) {
      print("insert quote error: ${error.toString()}");
    }
  }

  Future<Either<QuotesData, AccessError>> retrieveAll() async {
    try {
      final recordSnapshot = await _folder.find(await _db);
      return Left(recordSnapshot.map((snapshot){
        return QuotesData.fromJson(snapshot.value);
      }).toList()[0]);
    } catch (error) {
      print("retrieveAll currency error: ${error.toString()}");
      return null;
    }
  }

  Future deleteAll() async {
    try {
      await _folder.drop(await _db);
    } catch (error) {
      print("deleteAll quote error: ${error.toString()}");
    }
  }
}