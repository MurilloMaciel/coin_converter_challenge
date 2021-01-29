import 'package:coinconverterchallenge/core/network/model/NetworkStatus.dart';
import 'package:coinconverterchallenge/domain/repository/repository.dart';
import 'package:coinconverterchallenge/domain/usecase/check_network_status_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RepositoryImplMock extends Mock implements Repository {}

main() {

  Repository repository;
  CheckNetworkStatusUseCase usecase;

  setUp(() {
    repository = RepositoryImplMock();
    usecase = CheckNetworkStatusUseCase(repository);
  });

  group("CheckNetworkStatusUseCase tests", () {

    test("shoud check network status from repository", () async {
      when(repository.checkNetworkStatus()).thenAnswer((_) async => NetworkStatus.ONLINE);

      final result1 = await usecase.execute();

      expect(result1, NetworkStatus.ONLINE);



      when(repository.checkNetworkStatus()).thenAnswer((_) async => NetworkStatus.OFFLINE);

      final result2 = await usecase.execute();

      expect(result2, NetworkStatus.OFFLINE);
    });
  });

  tearDown(() {
    repository = null;
    usecase = null;
  });
}