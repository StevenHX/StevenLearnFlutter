import 'package:flutter/material.dart';
import 'package:learn_flutter/my/my_router.dart';
import 'package:learn_flutter/res/colors.dart';
import 'package:learn_flutter/route/fluro_navigator.dart';
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
    MineItemBean('collect', '我的收藏'),
    MineItemBean('night', '夜间模式'),
    MineItemBean('language', '多语言'),
    MineItemBean('about', '关于')
  ];
  @override
  void initState() {
    super.initState();
  }

  void onMyItemClick(int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        NavigatorUtils.push(context, MyRouter.themePage);
        break;
      case 2:
        NavigatorUtils.push(context, MyRouter.localPage);
        break;
      case 3:
        break;
      default:
    }
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
                    const LoadImage(
                      "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic%2F82%2Fce%2Fce%2F82cece1703856a860cb39d6a22d7ca26.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1651063270&t=4c27eb7644713b7dba335787429b7637",
                      width: 600,
                      height: 400,
                    )
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
              return GestureDetector(
                onTap: () {
                  onMyItemClick(index);
                },
                child: Container(
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
                ),
              );
            },
            itemCount: mineItemList.length,
          ),
        ),
      ),
    );
  }
}
