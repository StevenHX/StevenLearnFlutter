import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/deer_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:learn_flutter/route/routers.dart';
import 'home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Widget? home;
  final ThemeData? theme;
  MyApp({Key? key, this.home, this.theme}) : super(key: key) {
    Routes.initRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      backgroundColor: Colors.black54,
      textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      radius: 20.0,
      position: ToastPosition.bottom,
      child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              onGenerateRoute: Routes.router.generator,
              localizationsDelegates: DeerLocalizations.localizationsDelegates,
              supportedLocales: DeerLocalizations.supportedLocales,
              home: const MyHomePage(title: 'Flutter Demo Home Page'),
      )
    );
  }
}

