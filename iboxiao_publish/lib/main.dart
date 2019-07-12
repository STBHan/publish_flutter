import 'package:flutter/material.dart';
import 'package:iboxiao_publish/org/iboxiao/common/Bean.dart';
import 'package:iboxiao_publish/org/iboxiao/common/Constont.dart';
import 'package:iboxiao_publish/org/iboxiao/common/Parse.dart';
import 'package:iboxiao_publish/org/iboxiao/common/SP.dart';
import 'package:iboxiao_publish/org/iboxiao/pages/LoginPager.dart';

import 'org/iboxiao/pages/MainPager.dart';

Future main() async {
  StatelessWidget widget;

  bool isLogin =
      await ShapePreferences.getBool(SharedPreferenceKey.LOGIN_STATUS);
  if (isLogin == null) {
    isLogin = false;
  }

  String data=await ShapePreferences.getString(SharedPreferenceKey.TOKEN);
  Token token;

  if(data!=null) {
    token = Token.fromJson(Parser.parse(data));
  }

  if (isLogin) {
    widget = MainPager(token);
  } else {
    widget = LoginWidget();
  }

  runApp(widget);
}
