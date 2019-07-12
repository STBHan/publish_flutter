import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iboxiao_publish/org/iboxiao/common/Bean.dart';
import 'package:iboxiao_publish/org/iboxiao/pages/MyDevicePager.dart';
import 'package:iboxiao_publish/org/iboxiao/pages/MyProgramPager.dart';

import 'DeviceWorkSpacePager.dart';
import 'MyRollNoticePager.dart';
import 'PublishPicturePager.dart';
import 'SettingPager.dart';
import 'WorkSpacePager.dart';

/// 主界面

class MainPager extends StatelessWidget {
  Token token;

  MainPager(this.token);

  @override
  Widget build(BuildContext context) {
    return MainStatePager(token);
  }
}

class MainState extends State<MainStatePager> {
  MainState(this._token);

  //记录当前选择的位置
  int _currentIndex = 0;
  Token _token;

//  Text tile=new Text("信息发布系统");
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    return MainStatePager();
    return new MaterialApp(
        home: Builder(
            builder: (context) => new Scaffold(
                  drawer: new Drawer(
                    child: new Container(
                      child: _getLeftMenuList(context),
                      decoration: new BoxDecoration(
                        border: new Border.all(
                            color: Color(0xFFFFFF00), width: 0.5),
                        image: new DecorationImage(
                            image: AssetImage('images/leftdrawer.png'),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  appBar: _getAppBar(),
                  body: new Center(
                    child: new RaisedButton(
                      onPressed: () {
//                        Navigator.pop(context);
                      },
                      child: _getMainContent(context),
                    ),
                  ),
                )));
  }

  /// 获取各个界面的appBar
  AppBar _getAppBar() {
    AppBar appBar;
    String title;
    switch (_currentIndex) {
      case PagerIndex.HOME:
        title = '信息发布';
        appBar = new AppBar(
          title: Text(title),
          backgroundColor: Colors.black,
        );
        break;
      case PagerIndex.PROGRAM:
        title = '我的节目';
        appBar = new AppBar(
          title: Text(title),
          backgroundColor: Colors.black,
          actions: <Widget>[
            GestureDetector(
              child: new Image.asset(
                'images/search.png',
                scale: 1.8,
              ),
              onTap: () {
                _showToast("查询");
              },
            ),
            GestureDetector(
              child: new Image.asset(
                'images/move.png',
                scale: 1.8,
              ),
              onTap: () {
                _showToast('切换');
              },
            ),
          ],
        );

        break;
      case PagerIndex.DEVICE:
        title = '我的设备';
        appBar = new AppBar(
          title: Text(title),
          backgroundColor: Colors.black,
          actions: <Widget>[
            GestureDetector(
              child: new Image.asset(
                'images/operation.png',
                scale: 1.8,
              ),
              onTap: () {
                _showToast('我的设备列表');
              },
            ),
          ],
        );
        break;
      case PagerIndex.ROLL_NOTICE:
        title = '我的滚动通知';
        appBar = new AppBar(
          title: Text(title),
          backgroundColor: Colors.black,
          actions: <Widget>[
            GestureDetector(
              child: new Image.asset(
                'images/search.png',
                scale: 1.8,
              ),
              onTap: () {
                _showToast("查询");
              },
            ),
            GestureDetector(
              child: new Image.asset(
                'images/publish.png',
                scale: 1.8,
              ),
              onTap: () {
                _showToast('发布界面');
              },
            ),
          ],
        );
        break;
      case PagerIndex.WORK_SPACE:
        title = '工作区维护';
        appBar = new AppBar(
          title: Text(title),
          backgroundColor: Colors.black,
          actions: <Widget>[
            GestureDetector(
              child: new Image.asset(
                'images/add1.png',
                scale: 1.8,
              ),
              onTap: () {
                _showToast('添加工作区');
              },
            ),
          ],
        );
        break;
      case PagerIndex.DEVICE_MAIN_TAIN:
        title = '设备分组维护';
        appBar = new AppBar(
          title: Text(title),
          backgroundColor: Colors.black,
          actions: <Widget>[
            GestureDetector(
              child: new Image.asset(
                'images/add1.png',
                scale: 1.8,
              ),
              onTap: () {
                _showToast('添加设备分组');
              },
            ),
          ],
        );
        break;
      case PagerIndex.SETTING:
        title = '设置';
        appBar = new AppBar(
          title: Text(title),
          backgroundColor: Colors.black,
        );
        break;
      default:
        title = '未知';
        break;
    }
    return appBar;
  }

  ///获取用户头像url
  String _getUserIconUrl() {
    if (_token == null || _token.avatar == null) {
      return null;
    }
    if (_token.avatar.startsWith('http://')) {
      return _token.avatar;
    } else {
      return "http://" + _token.avatar;
    }
  }

  /// 返回 左侧侧拉menu

  Widget _getLeftMenuList(BuildContext context) {
    print("头像地址:" + _token.avatar);
    return Builder(
        builder: (context) => new ListView(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      new ClipOval(
                        child: _getUserIconUrl() == null
                            ? new Image.asset(
                                'images/home1.png',
                                scale: 1.0,
                              )
                            : Image.network(
                                _getUserIconUrl(),
                                scale: 0.5,
                              ),
                      ),
                      Container(
                        child: Text(_token.fullName),
                        margin: EdgeInsets.all(20.0),
                      ),
                    ],
                  ),
                  margin: new EdgeInsets.all(20.0),
                ),
                ListTile(
                  title: Text(
                    '首页',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: new Image.asset(
                    'images/home1.png',
                    scale: 1.8,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    print('首页');
                    setState(() {
                      _currentIndex = PagerIndex.HOME;
                    });
                  },
                ),
                new Divider(
                  color: Colors.white,
                  height: 0.1,
                  indent: 0.1,
                ),
                ListTile(
                  title: Text(
                    '我的节目',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: new Image.asset(
                    'images/program1.png',
                    scale: 1.8,
                  ),
                  onTap: () {
                    Navigator.pop(context);
//                          Navigator.push(
//                            context,
//                            new MaterialPageRoute(
//                                builder: (context) =>
//                                new MyProgramPager("我的节目")),
//                          );

                    setState(() {
                      _currentIndex = PagerIndex.PROGRAM;
                    });
//
//                    Navigator.of(context).push(
//                        MaterialPageRoute(builder: (context) => MainPager()));
                  },
                ),
                ListTile(
                  title: Text(
                    '我的设备',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: new Image.asset(
                    'images/mydevice1.png',
                    scale: 1.8,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _currentIndex = PagerIndex.DEVICE;
                    });
                  },
                ),
                ListTile(
                  title: Text(
                    '我的滚动通知',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: new Image.asset(
                    'images/myrollingnews1.png',
                    scale: 1.8,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _currentIndex = PagerIndex.ROLL_NOTICE;
                    });
                  },
                ),
                ListTile(
                  title: Text(
                    '工作区维护',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: new Image.asset(
                    'images/workspacemaintain1.png',
                    scale: 1.8,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _currentIndex = PagerIndex.WORK_SPACE;
                    });
                  },
                ),
                ListTile(
                  title: Text(
                    '设备分组维护',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: new Image.asset(
                    'images/devicemaintain1.png',
                    scale: 1.8,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _currentIndex = PagerIndex.DEVICE_MAIN_TAIN;
                    });
                  },
                ),
                ListTile(
                  title: Text(
                    '设置',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: new Image.asset(
                    'images/setting1.png',
                    scale: 1.8,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _currentIndex = PagerIndex.SETTING;
                    });
                  },
                ),
              ],
            ));

//    return ;
  }

  /// 侧拉menu切换时 主界面显示内容
  Widget _getMainContent(BuildContext context) {
    Widget mainContent;
    switch (_currentIndex) {
      case PagerIndex.HOME:
        mainContent = _getHome(context);
        break;
      case PagerIndex.PROGRAM:
        mainContent = MyProgramPager("我的节目");
        break;
      case PagerIndex.DEVICE:
        mainContent = MyDevicePager("我的设备");
        break;
      case PagerIndex.ROLL_NOTICE:
        mainContent = MyRollNoticePager("我的滚动通知");
        break;
      case PagerIndex.WORK_SPACE:
        mainContent = WorkSpacePager("工作区维护");
        break;
      case PagerIndex.DEVICE_MAIN_TAIN:
        mainContent = DeviceWorkSpacePager('设备分组维护');
        break;
      case PagerIndex.SETTING:
        mainContent = SettingPager('设置');
        break;
      default:
        break;
    }
    return mainContent;
  }
}

///提示想消息
void _showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      textColor: Colors.red,
      backgroundColor: Colors.yellow);
}

/// 获取界面内容
Widget _getHome(BuildContext context) {
  return GridView.count(
    //水平子Widget之间间距
    crossAxisSpacing: 0.0,
    //垂直子Widget之间间距
    mainAxisSpacing: 0.0,
    //GridView内边距
    padding: EdgeInsets.all(1.0),
    //一行的Widget数量
    crossAxisCount: 2,
    //子Widget宽高比例
    childAspectRatio: 2.0,
    //子Widget列表
    children: <Widget>[
      GestureDetector(
        child: Column(
          children: <Widget>[
            Expanded(
              child: new Image.asset(
                'images/publish_photo.png',
                scale: 1.8,
              ),
            ),
            Expanded(
              child: Text('发布图片'),
            ),
          ],
        ),
        onTap: () {
          print('发布图片');
          _showToast('发布图片');
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new PublishPicture()));
        },
      ),
      GestureDetector(
        child: Column(
          children: <Widget>[
            Expanded(
              child: new Image.asset(
                'images/publish_video.png',
                scale: 1.8,
              ),
            ),
            Expanded(
              child: Text('发布视频'),
            ),
          ],
        ),
        onTap: () {
          _showToast('发布视频');
        },
      ),
      GestureDetector(
        child: Column(
          children: <Widget>[
            Expanded(
              child: new Image.asset(
                'images/publish_take.png',
                scale: 1.8,
              ),
            ),
            Expanded(
              child: Text('照相'),
            ),
          ],
        ),
        onTap: () {
          _showToast('照相');
        },
      ),
      GestureDetector(
        child: Column(
          children: <Widget>[
            Expanded(
              child: new Image.asset(
                'images/publish_web.png',
                scale: 1.8,
              ),
            ),
            Expanded(
              child: Text('录像'),
            ),
          ],
        ),
        onTap: () {
          _showToast('录像');
        },
      ),
      GestureDetector(
        child: Column(
          children: <Widget>[
            Expanded(
              child: new Image.asset(
                'images/publish_notice.png',
                scale: 1.8,
              ),
            ),
            Expanded(
              child: Text('发布通知'),
            ),
          ],
        ),
        onTap: () {
          _showToast('发布通知');
        },
      ),
      GestureDetector(
        child: Column(
          children: <Widget>[
            Expanded(
              child: new Image.asset(
                'images/publish_roll.png',
                scale: 1.8,
              ),
            ),
            Expanded(
              child: Text('发布滚动通知'),
            ),
          ],
        ),
        onTap: () {
          _showToast('发布滚动通知');
        },
      ),
    ],
  );
}

class MainStatePager extends StatefulWidget {
  Token token;

  MainStatePager(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MainState(token);
  }
}

class PagerIndex {
  static const int HOME = 0; //主界面

  static const int PROGRAM = 1; //我的节目

  static const int DEVICE = 2; //我的设备

  static const int ROLL_NOTICE = 3; //我的滚动通知

  static const int WORK_SPACE = 4; // 工作区维护

  static const int DEVICE_MAIN_TAIN = 5; //设备分组维护

  static const int SETTING = 6; //设置
}
