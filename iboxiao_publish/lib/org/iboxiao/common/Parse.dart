import 'dart:convert';

class Parser {
  static Map<String, dynamic> parse(String jsonData) {
    /*先将字符串转成json*/
    Map<String, dynamic> json = jsonDecode(jsonData);
    /*将Json转成实体类*/
    return json;
  }
}
