import 'package:coinconverterchallenge/data/datasource/remote_datasource.dart';
import 'package:coinconverterchallenge/data/remote/remote_datasource_impl.dart';
import 'package:coinconverterchallenge/data/repository/repository_impl.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';
import 'package:coinconverterchallenge/domain/usecase/get_currencies_use_case.dart';
import 'package:coinconverterchallenge/domain/usecase/get_quotes_use_case.dart';
import 'package:coinconverterchallenge/presentation/test/test_controller.dart';
import 'package:get_it/get_it.dart';

class Di {

  static final getIt = GetIt.instance;

  static void init() {
    getIt.registerSingleton<RemoteDatasource>(RemoteDataSourceImpl());
    getIt.registerSingleton<Repository>(RepositoryImpl(getIt.get()));
    getIt.registerSingleton<GetCurrenciesUseCase>(GetCurrenciesUseCase(getIt.get()));
    getIt.registerSingleton<GetQuotesUseCase>(GetQuotesUseCase(getIt.get()));
  }

  static getTestController() => TestController(getIt.get(), getIt.get());
}