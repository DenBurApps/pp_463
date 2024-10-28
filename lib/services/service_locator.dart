
import 'package:get_it/get_it.dart';
import 'package:pp_463/services/database_service.dart';
import 'package:pp_463/services/flag_smith_service.dart';

class ServiceLocator {
  static Future<void> setup() async {

    GetIt.I.registerSingletonAsync<DatabaseService>(() => DatabaseService().init());
    await GetIt.I.isReady<DatabaseService>();

    GetIt.I.registerSingletonAsync<FlagSmithService>(() => FlagSmithService().init());
    await GetIt.I.isReady<FlagSmithService>();
  }
}
