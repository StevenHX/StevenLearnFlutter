import 'package:flutter/material.dart';
import 'package:learn_flutter/widgets/TabBarWidget.dart';
import 'package:learn_flutter/my/MyPage.dart';
import 'package:learn_flutter/util/toast_utils.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      _renderTab(const Text("电影")),
      _renderTab(const Text("图书")),
      _renderTab(const Text("我的"))
    ];
    DateTime? _lastPressedAt; //上次点击时间
    return WillPopScope(
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt!) > const Duration(seconds: 1)) {
          //两次点击间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();
          Toast.show("再按一次，退出应用！");
          return false;
        }
        return true;
      },
      child: TabBarWidget(
        title: const Text("电影App"),
        type: TabBarWidget.TOP_TAB,
        tabItems: tabs,
        tabViews: [MyPage(), MyPage(), MyPage()],
        backgroundColor: Theme.of(context).primaryColor,
        indicatorColor: Theme.of(context).indicatorColor,
      ),
    );
  }

  _renderTab(text) {
    //返回一个标签
    return Tab(
        child: Container(
      //设置paddingTop为6
      padding: const EdgeInsets.only(top: 6),
      //一个列控件
      child: Column(
        //竖直方向居中
        mainAxisAlignment: MainAxisAlignment.center,
        //水平方向居中
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[text],
      ),
    ));
  }
}
