import 'package:coinconverterchallenge/core/network/model/NetworkStatus.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';

class CheckNetworkStatusUseCase {

  Repository _repository;

  CheckNetworkStatusUseCase(this._repository);

  Future<NetworkStatus> execute() async => await _repository.checkNetworkStatus();
}
