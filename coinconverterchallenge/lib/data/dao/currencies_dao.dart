import 'package:coinconverterchallenge/core/db/app_database.dart';
import 'package:coinconverterchallenge/core/db/access_error.dart';
import 'package:coinconverterchallenge/data/model/currencies_data.dart';
import 'package:dartz/dartz.dart';
import 'package:sembast/sembast.dart';

class CurrenciesDao {

  static const String _folderName = "currencies_path";
  final _folder = intMapStoreFactory.store(_folderName);

  Future<Database> get  _db  async => await AppDatabase.instance.database;

  Future insert(CurrenciesData currency) async {
    try {
      await  _folder.add(await _db, currency.toJson());
    } catch (error) {
      print("insert currency error: ${error.toString()}");
    }
  }

  Future<Either<AccessError, CurrenciesData>> retrieveAll() async {
    try {
      final recordSnapshot = await _folder.find(await _db);
      return Right(recordSnapshot.map((snapshot){
        return CurrenciesData.fromJson(snapshot.value);
      }).toList()[0]);
    } catch (error) {
      print("retrieveAll currency error: ${error.toString()}");
      return Left(AccessError(
        "Ocorreu um erro ao recuperar as moedas disponíveis. Você precisa de internet para recupera-las ao menos uma vez."
      ));
    }
  }

  Future deleteAll() async {
    try {
      await _folder.drop(await _db);
    } catch (error) {
      print("deleteAll currency error: ${error.toString()}");
    }
  }
}