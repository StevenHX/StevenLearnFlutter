import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:learn_flutter/login/login_router.dart';
import 'package:learn_flutter/route/fluro_navigator.dart';

class MainSubOnePage extends StatefulWidget {
  const MainSubOnePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MainSubOnePage();
  }
}

class _MainSubOnePage extends State<MainSubOnePage> {
  static const loadingTag = "##loading##"; //表尾标记
  final _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView.separated(
        itemCount: _words.length,
        itemBuilder: (context, index) {
          //如果到了表尾
          if (_words[index] == loadingTag) {
            //不足100条，继续获取数据
            if (_words.length - 1 < 100) {
              //获取数据
              _retrieveData();
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
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                height: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      _words[index],
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          padding: const EdgeInsets.only(left: 4, right: 4),
                          child: Text(_words[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.blueGrey)),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(width: 1, color: Colors.grey)),
                        ),
                        const Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "123123",
                            style:
                                TextStyle(fontSize: 12, color: Colors.black26),
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
        separatorBuilder: (context, index) => const Divider(height: .0),
      ),
    );
  }

  void _retrieveData() {
    Future.delayed(const Duration(seconds: 2)).then((e) {
      setState(() {
        //重新构建列表
        _words.insertAll(
          _words.length - 1,
          //每次生成20个单词
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList(),
        );
      });
    });
  }
}
