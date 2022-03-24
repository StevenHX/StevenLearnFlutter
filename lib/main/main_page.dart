import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/http/dio_method.dart';
import 'package:learn_flutter/main/banner_model.dart';
import 'package:learn_flutter/main/main_subOne_page.dart';
import 'package:learn_flutter/main/main_subtwo_page.dart';
import 'package:learn_flutter/res/resources.dart';

import '../http/dio_response.dart';
import '../http/dio_util.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Image> imgs = [];

  final CancelToken _cancelToken = CancelToken();
  void requestBannerList() async {
    DioUtil.getInstance()?.openLog();
    DioResponse response = await DioUtil().request("/banner/json",
        method: DioMethod.get, cancelToken: _cancelToken);
    BannerModel banner = BannerModel.fromJson(response.data);
    banner.data?.forEach((item) => {
          setState(() => {
                imgs.add(Image.network(
                  item.imagePath.toString(),
                  fit: BoxFit.cover,
                ))
              })
        });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    requestBannerList();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 230.0,
            pinned: true,
            title: const Text("毛孩子大全"),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  print("saerch");
                },
              ),
            ],
            backgroundColor: Colours.bg_gray,
            flexibleSpace: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: SizedBox(
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return imgs[index];
                  },
                  itemCount: imgs.length,
                  autoplay: true,
                  viewportFraction: 1,
                  scale: 1,
                ),
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyTabBarDelegate(
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Colors.black,
                controller: _tabController,
                tabs: const <Widget>[
                  Tab(text: '资讯'),
                  Tab(text: '技术'),
                ],
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          MainSubOnePage(),
          MainSubTwoPage(),
        ],
      ),
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;
  StickyTabBarDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colours.bg_gray,
      child: child,
    );
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
