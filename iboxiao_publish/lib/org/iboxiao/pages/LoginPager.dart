import 'package:flutter/material.dart';
import 'package:iboxiao_publish/org/iboxiao/common/Bean.dart';
import 'package:iboxiao_publish/org/iboxiao/common/Constont.dart';
import 'package:iboxiao_publish/org/iboxiao/common/Net.dart';
import 'package:iboxiao_publish/org/iboxiao/common/Parse.dart';
import 'package:iboxiao_publish/org/iboxiao/common/SP.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iboxiao_publish/org/iboxiao/pages/MainPager.dart';

///
/// 登录界面

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: "信息发布系统",
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _userNameEditController;
  TextEditingController _pwdEditController;

  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _pwdFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pwdEditController = TextEditingController();
    _userNameEditController = TextEditingController();
    _pwdEditController.addListener(() => setState(() => {}));
    _userNameEditController.addListener(() => setState(() => {}));
  }

  void _login() async {
    debugPrint(' \n======================= 开始请求 =======================\n');
    String userName = _userNameEditController.text;
    String pwd = _pwdEditController.text;
    Map<String, String> paramsMap = new Map();
    paramsMap['phoneNo'] = userName;
    paramsMap['scUserPwd'] = pwd;
    paramsMap['appId'] = "bxc82a3f0b";
    HttpController.post(IBXURL.LOGIN_URL, (data) {
      String result = data;
      print(result);
      LoginBean loginBean = LoginBean.fromJson(Parser.parse(result));
      if (loginBean != null &&
          loginBean.status &&
          loginBean.data != null &&
          loginBean.data.userId != null) {
        ShapePreferences.setString(
            SharedPreferenceKey.USER_ID_KEY, loginBean.data.userId);
        String url = loginBean.data.adapterUrl;
        HttpController.get(url + IBXURL.GET_ADDRESS, (data) {
          String addressUrl = data;
          Fluttertoast.showToast(
              msg: "登录成功！！！",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              textColor: Colors.red,
              backgroundColor: Colors.yellow);
          print("地址:" + data);
          if (addressUrl != null) {
            Map<String, String> map = new Map();
            map['code'] = loginBean.data.code;
            HttpController.get(addressUrl + IBXURL.GET_TOKEN, (data) {
              print("获取Token:" + data);
              try {
                Token token = Token.fromJson(Parser.parse(data));
                if (token != null) {
                  ShapePreferences.setString(SharedPreferenceKey.TOKEN, data);
                  ShapePreferences.setBool(
                      SharedPreferenceKey.LOGIN_STATUS, true);
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new MainPager(token)),
                  );
                }
              } catch (e) {
                print("异常:$e");
              }
            }, params: map);
          } else {
            print("获取地址:" + addressUrl);
          }
        });

        //跳转到主界面
      } else {
        print("登录失败");
      }
    }, params: paramsMap);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: new Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Flexible(
              child: new Column(
            children: <Widget>[
              Flexible(
                child: new Padding(
                  padding: new EdgeInsets.fromLTRB(0.0, 100.0, 5.0, 0.0),
                  child: new Image.asset(
                    'images/login.png',
                    scale: 1.8,
                  ),
                ),
              ),
              Flexible(
                child: new Container(
                  margin: new EdgeInsets.all(20.0),
                  decoration: new BoxDecoration(color: Colors.grey[200]),
                  child: new Column(
                    children: <Widget>[
                      Flexible(
                        child: new Padding(
                          padding:
                              new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 15.0),
                          child: new Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Padding(
                                padding: new EdgeInsets.fromLTRB(
                                    0.0, 20.0, 5.0, 0.0),
                                child: new Image.asset(
                                  'images/username.png',
                                  width: 40.0,
                                  height: 40.0,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              new Expanded(
                                  child: new Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: new TextField(
                                  focusNode: _userNameFocusNode,
                                  controller: _userNameEditController,
                                  textAlign: TextAlign.start,
                                  decoration: new InputDecoration(
                                    hintText: '数字校园客户端账号',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 0.5,
                        color: Colors.grey[350],
                      ),
                      Flexible(
                        child: new Padding(
                          padding:
                              new EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
                          child: new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Padding(
                                padding:
                                    new EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                                child: new Image.asset(
                                  'images/password.png',
                                  width: 40.0,
                                  height: 40.0,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              new Expanded(
                                child: new TextField(
                                  controller: _pwdEditController,
                                  focusNode: _pwdFocusNode,
                                  decoration: new InputDecoration(
                                    hintText: '请输入密码',
                                    border: InputBorder.none,
                                  ),
                                  obscureText: true,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: new Container(
                  margin: new EdgeInsets.all(20.0),
                  width: double.infinity,
                  child: new Card(
                    color: Colors.red,
                    elevation: 16.0,
                    child: new FlatButton(
                      onPressed: _login,
                      child: new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Text(
                          '登录',
                          style: new TextStyle(
                              color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
          new Container(
            width: double.infinity,
            margin: new EdgeInsets.all(40.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Flexible(
                      child: new Padding(
                        padding: new EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                        child: Divider(
                          height: 0.5,
                          color: Colors.grey[350],
                        ),
                      ),
                    ),
                    Flexible(
                      child: new Image.asset(
                        'images/loginquick.png',
                        scale: 2.0,
                      ),
                    ),
                    new Flexible(
                      child: new Padding(
                        padding: new EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        child: Divider(
                          height: 0.5,
                          color: Colors.grey[350],
                        ),
                      ),
                    ),
                  ],
                ),
                new Padding(
                  padding: new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  child: new Text('数字校园客户端快速登录'),
                )
              ],
            ),
          ),
        ],
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
