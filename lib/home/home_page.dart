import 'package:flutter/material.dart';
import 'package:learn_flutter/main/main_page.dart';
import 'package:learn_flutter/my/my_page.dart';
import 'package:learn_flutter/res/resources.dart';
import 'package:learn_flutter/widgets/load_image.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget? currentPage;
  int currentIndex = 0;
  final List<Widget> _tabs = [const MainPage(), const MyPage()];
  final List<BottomNavigationBarItem> _bottomTabs = [
    const BottomNavigationBarItem(
      icon: LoadAssetImage(
        'home',
        width: 28.0,
        height: 28.0,
        fit: BoxFit.cover,
      ),
      activeIcon: LoadAssetImage(
        'home_press',
        width: 28.0,
        height: 28.0,
        fit: BoxFit.cover,
      ),
      label: '首页',
    ),
    const BottomNavigationBarItem(
      icon: LoadAssetImage(
        'me',
        width: 28.0,
        height: 28.0,
        fit: BoxFit.cover,
      ),
      activeIcon: LoadAssetImage(
        'me_press',
        width: 28.0,
        height: 28.0,
        fit: BoxFit.cover,
      ),
      label: '我的',
    )
  ];
  @override
  void initState() {
    super.initState();
    currentPage = _tabs[currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: _bottomTabs,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            currentPage = _tabs[currentIndex];
          });
        },
      ),
    );
  }
}
