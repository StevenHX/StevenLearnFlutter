import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/login/login_router.dart';
import 'package:learn_flutter/main/article_model.dart';
import 'package:learn_flutter/route/fluro_navigator.dart';

import '../http/dio_method.dart';
import '../http/dio_response.dart';
import '../http/dio_util.dart';

class MainSubOnePage extends StatefulWidget {
  const MainSubOnePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MainSubOnePage();
  }
}

class _MainSubOnePage extends State<MainSubOnePage> {
  static const loadingTag = "##loading##"; //表尾标记

  // 列表数据源
  List<Datas> list = [Datas(tag: loadingTag)];
  int tolalNum = 1;
  int pageNum = 0;

  final CancelToken _cancelToken = CancelToken();

  Future<void> handleArtileList(int num) async {
    pageNum = num;
    DioUtil.getInstance()?.openLog();
    DioResponse response = await DioUtil().request(
        "/article/list/" + num.toString() + "/json",
        method: DioMethod.get,
        cancelToken: _cancelToken);
    ArticleModel model = ArticleModel.fromJson(response.data);
    setState(() {
      if (num == 0) {
        list = [Datas(tag: loadingTag)];
      }
      list.insertAll(list.length - 1, model.data!.datas!);
      tolalNum = model.data!.total!;
    });
  }

  @override
  void initState() {
    super.initState();
    handleArtileList(pageNum);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: RefreshIndicator(
        onRefresh: () => handleArtileList(0),
        child: ListView.separated(
            itemCount: list.length,
            itemBuilder: (context, index) {
              //如果到了表尾
              if (list[index].tag == loadingTag) {
                //不足100条，继续获取数据
                if (list.length - 1 < tolalNum) {
                  //获取数据
                  handleArtileList(++pageNum);
                  //加载时显示loading
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: const SizedBox(
                      width: 24.0,
                      height: 24.0,
                      child: CircularProgressIndicator(strokeWidth: 2.0),
                    ),
                  );
                } else {
                  //已经加载了100条数据，不再获取数据。
                  return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child: const Text(
                      "没有更多了",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
              }
              //显示列表项
              return GestureDetector(
                child: Container(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                    height: 90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          list[index].title!,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 20,
                              padding: const EdgeInsets.only(left: 4, right: 4),
                              child: Text(list[index].shareUser!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.blueGrey)),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  border:
                                      Border.all(width: 1, color: Colors.grey)),
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                list[index].niceDate!,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black26),
                              ),
                            ))
                          ],
                          verticalDirection: VerticalDirection.up,
                          mainAxisAlignment: MainAxisAlignment.start,
                        ),
                      ],
                    )),
                onTap: () {
                  NavigatorUtils.push(context, LoginRouter.loginPage);
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(height: .0)),
      ),
    );
  }
}
