import 'package:flutter/material.dart';
import 'package:pp_463/router/router.dart';
import 'package:pp_463/theme/theme.dart';

class PP463App extends StatelessWidget {
  PP463App({super.key});

  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '1My Eat Menu Mate',
      theme: lightMode,
      routerConfig: _router.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}
