import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:pp_463/data/database_keys.dart';
import 'package:pp_463/pp_463_app.dart';
import 'package:pp_463/screens/ration/ration_bloc/ration_bloc.dart';
import 'package:pp_463/screens/recipe/recipe_bloc/recipe_bloc.dart';
import 'package:pp_463/screens/statistic/statistic_bloc/statistic_bloc.dart';
import 'package:pp_463/services/database_service.dart';
import 'package:pp_463/services/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initApp();

  final isFirstRun = await IsFirstRun.isFirstRun();
  final _databaseService = GetIt.instance<DatabaseService>();

  if (isFirstRun) {
    _databaseService.setInitialRation();
    _databaseService.setInitialNutrition();

    _databaseService.put(DatabaseKeys.seenOnboarding, true);
  } else {
    _databaseService.put(DatabaseKeys.seenOnboarding, false);
  }

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    AppInfo(
      data: await AppInfoData.get(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<RationBloc>(create: (context) => RationBloc()),
          BlocProvider<RecipeBloc>(create: (context) => RecipeBloc()),
          BlocProvider<StatisticBloc>(create: (context) => StatisticBloc()),
        ],
        child: PP463App(),
      ),
    ),
  );
}

Future<void> _initApp() async {
  // try {
  //   await Firebase.initializeApp(
  //       options: DefaultFirebaseOptions.currentPlatform);
  //   FlutterError.onError = (errorDetails) {
  //     FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  //   };
  //   PlatformDispatcher.instance.onError = (error, stack) {
  //     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //     return true;
  //   };
  // } on Exception catch (e) {
  //   log("Failed to initialize Firebase: $e");
  // }

  await ServiceLocator.setup();
}
