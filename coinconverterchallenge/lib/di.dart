import 'package:coinconverterchallenge/core/helper/navigation_helper.dart';
import 'package:coinconverterchallenge/data/datasource/local_datasource.dart';
import 'package:coinconverterchallenge/data/datasource/remote_datasource.dart';
import 'package:coinconverterchallenge/data/local/local_datasource_impl.dart';
import 'package:coinconverterchallenge/data/remote/remote_datasource_impl.dart';
import 'package:coinconverterchallenge/data/repository/repository_impl.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';
import 'package:coinconverterchallenge/domain/usecase/check_network_status_use_case.dart';
import 'package:coinconverterchallenge/domain/usecase/delete_currencies_use_case.dart';
import 'package:coinconverterchallenge/domain/usecase/delete_quotes_use_case.dart';
import 'package:coinconverterchallenge/domain/usecase/get_currencies_use_case.dart';
import 'package:coinconverterchallenge/domain/usecase/get_local_currencies_use_case.dart';
import 'package:coinconverterchallenge/domain/usecase/get_local_quotes_use_case.dart';
import 'package:coinconverterchallenge/domain/usecase/get_quotes_use_case.dart';
import 'package:coinconverterchallenge/domain/usecase/persist_currencies_use_case.dart';
import 'package:coinconverterchallenge/domain/usecase/persist_quotes_use_case.dart';
import 'package:coinconverterchallenge/domain/usecase/update_local_currencies_use_case.dart';
import 'package:coinconverterchallenge/domain/usecase/update_local_quotes_use_case.dart';
import 'package:coinconverterchallenge/presentation/coins_page/coins_controller.dart';
import 'package:coinconverterchallenge/presentation/conversion_page/conversion_controller.dart';
import 'package:coinconverterchallenge/presentation/splash_page/splash_controller.dart';
import 'package:get_it/get_it.dart';

import 'domain/usecase/calculate_coin_conversion_use_case.dart';

class Di {

  static final getIt = GetIt.instance;

  static void init() {
    getIt.registerSingleton<NavigationHelper>(NavigationHelper());
    getIt.registerSingleton<RemoteDatasource>(RemoteDataSourceImpl());
    getIt.registerSingleton<LocalDatasource>(LocalDatasourceImpl());
    getIt.registerSingleton<Repository>(RepositoryImpl(getIt.get(), getIt.get()));

    getIt.registerSingleton<CalculateCoinConversionUseCase>(CalculateCoinConversionUseCase());
    getIt.registerSingleton<CheckNetworkStatusUseCase>(CheckNetworkStatusUseCase(getIt.get()));
    getIt.registerSingleton<GetLocalCurrenciesUseCase>(GetLocalCurrenciesUseCase(getIt.get()));
    getIt.registerSingleton<GetLocalQuotesUseCase>(GetLocalQuotesUseCase(getIt.get()));
    getIt.registerSingleton<PersistCurrenciesUseCase>(PersistCurrenciesUseCase(getIt.get()));
    getIt.registerSingleton<PersistQuotesUseCase>(PersistQuotesUseCase(getIt.get()));
    getIt.registerSingleton<DeleteCurrenciesUseCase>(DeleteCurrenciesUseCase(getIt.get()));
    getIt.registerSingleton<DeleteQuotesUseCase>(DeleteQuotesUseCase(getIt.get()));
    getIt.registerSingleton<UpdateLocalCurrenciesUseCase>(UpdateLocalCurrenciesUseCase(getIt.get()));
    getIt.registerSingleton<UpdateLocalQuotesUseCase>(UpdateLocalQuotesUseCase(getIt.get()));
    getIt.registerSingleton<GetCurrenciesUseCase>(GetCurrenciesUseCase(getIt.get(), getIt.get(), getIt.get(), getIt.get()));
    getIt.registerSingleton<GetQuotesUseCase>(GetQuotesUseCase(getIt.get(), getIt.get(), getIt.get(), getIt.get()));
  }

  static getSplashController() => SplashController();

  static getCoinsController() => CoinsController(getIt.get());

  static getConversionController() => ConversionController(getIt.get(), getIt.get());
}