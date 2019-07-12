import 'dart:async';

import 'package:iboxiao_publish/org/iboxiao/common/Bean.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'Constont.dart';

class ShapePreferences {
  static Token TOKEN ;

  static void setString(String key, String value) async {
    if (key == null) {
      return;
    }

    if (value == null) {
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(key, value);
  }

  static Future<String> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static void setInt(String key, int value) async {
    if (key == null) {
      return;
    }

    if (value == null) {
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt(key, value);
  }

  static Future<int> getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getInt(key);
  }

  static void setBool(String key, bool value) async {
    if (key == null) {
      return;
    }

    if (value == null) {
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool(key, value);
  }

  static Future<bool> getBool(String key) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);

  }

}




class FileController {
  static void saveUserInfo2File(Token token) async {
    File file = await _getLocalFile();
    IOSink sink = file.openWrite(mode: FileMode.write);
    sink.write(token);
    sink.close();
  }

  /// 此方法返回本地文件地址
  static Future<File> _getLocalFile() async {
    // 获取文档目录的路径
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dir = appDocDir.path;
    final file = new File('$dir' + SharedPreferenceKey.SERIALIZABLE_USER);
    // print(file);
    return file;
  }
}
