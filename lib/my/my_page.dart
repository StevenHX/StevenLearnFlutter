import 'package:flutter/material.dart';
import 'package:learn_flutter/res/colors.dart';
import 'package:learn_flutter/util/view_utils.dart';

import '../widgets/load_image.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyPage();
  }
}

class MineItemBean {
  String iconPath;
  String title;
  MineItemBean(this.iconPath, this.title);
}

class _MyPage extends State<MyPage> {
  List<MineItemBean> mineItemList = [
    MineItemBean('me', '我的收藏'),
    MineItemBean('me', '积分排行'),
    MineItemBean('me', '设置'),
    MineItemBean('me', '关于')
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 250,
                pinned: true, //固定顶部
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  titlePadding: const EdgeInsets.only(left: 15),
                  title: const Text("StevenHX"),
                  background: Stack(
                    children: [
                      GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4, //横轴三个子widget
                                  childAspectRatio: 1.0 //宽高比为1时，子widget
                                  ),
                          children: const <Widget>[
                            Icon(Icons.ac_unit),
                            Icon(Icons.airport_shuttle),
                            Icon(Icons.all_inclusive),
                            Icon(Icons.beach_access),
                            Icon(Icons.cake),
                            Icon(Icons.free_breakfast),
                            Icon(Icons.free_breakfast),
                            Icon(Icons.free_breakfast),
                          ]),
                    ],
                  ),
                ),
              )
            ];
          },
          body: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  height: 70,
                  decoration: BoxDecoration(border: borderLine(context)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          LoadAssetImage(
                            mineItemList[index].iconPath,
                            width: 28.0,
                            height: 28.0,
                            fit: BoxFit.cover,
                          ),
                          viewSpace(width: 30),
                          Text(mineItemList[index].title,
                              style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: mineItemList.length,
            ),
          )),
    );
  }
}
