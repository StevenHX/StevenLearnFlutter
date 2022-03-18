import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/deer_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:learn_flutter/route/routers.dart';
import 'home/home_page.dart';
import 'package:learn_flutter/util/toast_utils.dart';

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
    DateTime? _lastPressedAt;
    return OKToast(
        backgroundColor: Colors.black54,
        textPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
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
          home: WillPopScope(
            child: const MyHomePage(),
            onWillPop: () async {
              if (_lastPressedAt == null ||
                  DateTime.now().difference(_lastPressedAt!) >
                      const Duration(seconds: 1)) {
                //两次点击间隔超过1秒则重新计时
                _lastPressedAt = DateTime.now();
                Toast.show("再按一次，退出应用！");
                return false;
              }
              return true;
            },
          ),
        ));
  }
}
