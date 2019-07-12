import 'package:flutter/material.dart';

class MyProgramPager extends StatelessWidget {
  final String pageText; //定义一个常量，用于保存跳转进来获取到的参数

  MyProgramPager(this.pageText); //构造函数，获取参数

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text('我的节目'),
      ),
    );
  }
}
