import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:learn_flutter/route/i_router.dart';
import 'package:learn_flutter/route/not_found_page.dart';

import 'package:learn_flutter/login/login_router.dart';
import 'package:learn_flutter/my/my_router.dart';

class Routes {

  static String webViewPage = '/webView';

  static final List<IRouterProvider> _listRouter = [];

  static final FluroRouter router = FluroRouter();

  static void initRoutes() {
    /// 指定路由跳转错误返回页
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        debugPrint('未找到目标页');
        return const NotFoundPage();
      });

    _listRouter.clear();
    /// 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.add(LoginRouter());
    _listRouter.add(MyRouter());

    /// 初始化路由
    void initRouter(IRouterProvider routerProvider) {
      routerProvider.initRouter(router);
    }
    _listRouter.forEach(initRouter);
  }
}
