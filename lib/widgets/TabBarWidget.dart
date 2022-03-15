import 'package:flutter/material.dart';

class TabBarWidget extends StatefulWidget {
  //底部模式
  static const int BOTTOM_TAB = 1;
  //顶部模式
  static const int TOP_TAB = 2;

  final int? type;
  final List<Widget>? tabItems;
  final List<Widget>? tabViews;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final Widget? title;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final ValueChanged<int>? onPageChanged;

  TabBarWidget(
      {Key? key,
      this.type,
      this.tabItems,
      this.tabViews,
      this.backgroundColor,
      this.indicatorColor,
      this.title,
      this.drawer,
      this.floatingActionButton,
      this.onPageChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TabBarState(type, tabViews, indicatorColor,
        title, drawer, onPageChanged);
  }
}

class _TabBarState extends State<TabBarWidget>
    with SingleTickerProviderStateMixin {
  final int? _type;
  final List<Widget>? _tabViews;
  final Color? _indicatorColor;
  final Widget? _title;
  final Widget? _drawer;
  final ValueChanged<int>? _onPageChanged;

  _TabBarState(this._type, this._tabViews, this._indicatorColor, this._title,
      this._drawer, this._onPageChanged)
      : super();

  TabController? _tabController;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.tabItems!.length, vsync: this);
    _pageController = PageController(initialPage: 0, keepPage: true);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
    _pageController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (this._type == TabBarWidget.TOP_TAB) {
      return Scaffold(
        drawer: _drawer,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: _title,
          bottom: TabBar(
            tabs: widget.tabItems!,
            controller: _tabController,
            indicatorColor: _indicatorColor,
            onTap: (index) {
              _pageController?.jumpToPage(index);
            },
          ),
        ),
        body: PageView(
          controller: _pageController,
          children: _tabViews!,
          onPageChanged: (index) {
            _tabController?.animateTo(index);
            _onPageChanged?.call(index);
          },
        ),
      );
    }
    return Scaffold(
      drawer: _drawer,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: _title,
      ),
      body: TabBarView(
        children: _tabViews!,
        controller: _tabController,
      ),
      bottomNavigationBar: Material(
        color: Theme.of(context).primaryColor,
        child: TabBar(
          tabs: widget.tabItems!,
          indicatorColor: _indicatorColor,
          controller: _tabController,
        ),
      ),
    );
  }
}
