import 'dart:async';
import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:pp_463/data/database_keys.dart';
import 'package:pp_463/router/router.dart';
import 'package:pp_463/screens/privacy_view.dart';
import 'package:pp_463/services/database_service.dart';
import 'package:pp_463/services/flag_smith_service.dart';

import '../helpers/dialog_helper.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _databaseService = GetIt.instance<DatabaseService>();
  final _remoteConfigService = GetIt.instance<FlagSmithService>();
  final _connectivity = Connectivity();

  late bool usePrivacy;

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    await _initConnectivity(
          () async => await DialogHelper.showNoInternetDialog(context),
    );
    usePrivacy = _remoteConfigService.usePrivacy;
    WidgetsBinding.instance.addPostFrameCallback((_) => _navigate());
  }

  Future<void> _initConnectivity(Future<void> Function() callback) async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        await callback.call();
        return;      }
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;    }

    if (!mounted) {
      return Future.value(null);
    }
  }

  void _navigate() {
    final seenAppReview = _databaseService.get(DatabaseKeys.seenAppReview) ?? false;
    if (!seenAppReview) {
      InAppReview.instance.requestReview();
      _databaseService.put(DatabaseKeys.seenAppReview, true);
    }

    if (usePrivacy) {
      final seenOnboarding =
          _databaseService.get(DatabaseKeys.seenOnboarding) ?? false;
      if (!seenOnboarding) {
        _databaseService.setInitialRation();
        _databaseService.setInitialNutrition();
        _databaseService.put(DatabaseKeys.seenOnboarding, true);
        context.router.push(const OnboardingRoute());
      } else {
        context.router.push(const MainRoute());
      }
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PrivacyView()));
    }

    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}