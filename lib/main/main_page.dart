import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/main/main_subOne_page.dart';
import 'package:learn_flutter/main/main_subtwo_page.dart';
import 'package:learn_flutter/res/resources.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Image> imgs = [
    //建立了一个图片数组
    Image.network(
      "https://images.unsplash.com/photo-1477346611705-65d1883cee1e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      fit: BoxFit.cover,
    ),
    Image.network(
      "https://images.unsplash.com/photo-1498550744921-75f79806b8a7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
      fit: BoxFit.cover,
    ),
    Image.network(
      "https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      fit: BoxFit.cover,
    ),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
