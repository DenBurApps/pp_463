import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:pp_463/pp_463_app.dart';
import 'package:pp_463/screens/ration/ration_bloc/ration_bloc.dart';
import 'package:pp_463/screens/recipe/recipe_bloc/recipe_bloc.dart';
import 'package:pp_463/screens/statistic/statistic_bloc/statistic_bloc.dart';
import 'package:pp_463/services/flag_smith_service.dart';
import 'package:pp_463/services/service_locator.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await _initApp();

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
  await ServiceLocator.setup();
  addLifecycleHandler();
}

void addLifecycleHandler() {
  WidgetsBinding.instance.addObserver(AppLifecycleListener(
    onDetach: GetIt.instance<FlagSmithService>().closeClient,
  ));
}
