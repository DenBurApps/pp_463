
import 'package:get_it/get_it.dart';
import 'package:pp_463/services/database_service.dart';

class ServiceLocator {
  static Future<void> setup() async {

    GetIt.I.registerSingletonAsync<DatabaseService>(() => DatabaseService().init());
    await GetIt.I.isReady<DatabaseService>();

    // GetIt.I.registerSingletonAsync<RemoteConfigService>(() => RemoteConfigService().init());
    // await GetIt.I.isReady<RemoteConfigService>();
  }
}
