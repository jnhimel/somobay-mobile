import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:somobay/utils/utils.dart';
import 'package:somobay/view/dashboard_screen.dart';
import 'package:somobay/view/deposits_screen.dart';
import 'package:somobay/view/loans_screen.dart';
import 'package:somobay/view/login_screen.dart';
import 'package:somobay/view/profile_screen.dart';

import 'constants.dart';

Future<void> main() async {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  static final String title = 'Has Internet?';
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectivitySnackBar);
  }

  @override
  void dispose() {
    subscription.cancel();

    super.dispose();
  }

  void showConnectivitySnackBar(ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;
    final message = hasInternet
        ? 'You are connected ${result == ConnectivityResult.mobile ? "to mobile data" : result == ConnectivityResult.wifi ? "to wifi" : ""}'
        : 'You have no internet';
    final color = hasInternet ? Colors.green : Colors.red;

    Utils.showTopSnackBar(context, message, color);
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Source Sans Pro',
          scaffoldBackgroundColor: kBackgroundColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: LoginScreen.id,
        routes: {
          // SignUpScreen.id: (context) => SignUpScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          Dashboard.id: (context) => Dashboard(),
          ProfileScreen.id: (context) => ProfileScreen(),
          DepositsListScreen.id: (context) => DepositsListScreen(),
          LoansListScreen.id: (context) => LoansListScreen(),
        },
      ),
    );
  }
}
