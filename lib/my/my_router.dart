import 'package:fluro/fluro.dart';
import 'package:learn_flutter/route/i_router.dart';

import 'theme_page.dart';
import 'locale_page.dart';


class MyRouter implements IRouterProvider{

  static String themePage = '/ThemePage';
  static String localPage = '/LocalePage';

  @override
  void initRouter(FluroRouter router) {
    router.define(themePage, handler: Handler(handlerFunc: (_, __) => const ThemePage()));
    router.define(localPage, handler: Handler(handlerFunc: (_, __) => const LocalePage()));
  }
}