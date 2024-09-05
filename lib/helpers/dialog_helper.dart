import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_info/flutter_app_info.dart';

class DialogHelper {
  static Future<void> showNoInternetDialog(BuildContext context) async =>
      await showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text(
              'You have lost your internet connection. Please check your settings and try again.'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                // Navigator.of(context).pop();
                // context.router.push(SplashRoute());
              },
            ),
          ],
        ),
      );

  static Future<void> showAppVersionDialog(BuildContext context) async {
    final info = AppInfo.of(context);
    await showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoAlertDialog(
        title: Text(info.package.appName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Operating system: ${info.platform.operatingSystem}'),
            SizedBox(height: 8),
            Text('Installer store: ${info.package.installerStore ?? '-'}'),
            SizedBox(height: 8),
            Text('Version: ${info.package.versionWithoutBuild}'),
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(
              'OK',
              style: TextStyle().copyWith(color: CupertinoColors.activeBlue),
            ),
            onPressed: Navigator.of(context).pop,
          ),
        ],
      ),
    );
  }

  static void showCustomModalPopup(BuildContext context, Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        // height: 216,
        padding: const EdgeInsets.only(top: 6.0),

        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          // bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: Colors.transparent,
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }
}