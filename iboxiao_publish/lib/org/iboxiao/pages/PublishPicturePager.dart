import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ImagePickerState();
  }
}

class _ImagePickerState extends State<ImagePickerWidget> {
  var _imgPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ImagePicker"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _ImageView(_imgPath),
              RaisedButton(
                onPressed: _takePhoto,
                child: Text("拍照"),
              ),
              RaisedButton(
                onPressed: _openGallery,
                child: Text("选择照片"),
              ),
            ],
          ),
        ));
  }

  /*图片控件*/
  Widget _ImageView(imgPath) {
    if (imgPath == null) {
      return Center(
        child: Text("请选择图片或拍照"),
      );
    } else {
      return Image.file(
        imgPath,
      );
    }
  }

  /*拍照*/
  _takePhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _imgPath = image;
    });
  }

  /*相册*/
  _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imgPath = image;
    });
  }
}

///上传图片

class PublishPicture extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new PublishPictureState();
  }
}

///上传图片的状态类

class PublishPictureState extends State<PublishPicture> {
  TextEditingController content_Controller = TextEditingController();

  FocusNode content_FocusMode = FocusNode();
  List<Asset> images = List<Asset>();
  Asset _addPic = Asset('', '', 300, 300);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    images.add(_addPic);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('发布图片'),
          leading: InkWell(
            child: new Icon(Icons.navigate_before),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
          actions: <Widget>[
            InkWell(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('发布'),
                  )
                ],
              ),
              onTap: () {},
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            new ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: double.infinity, maxWidth: double.infinity),
              child: new TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
                  hintText: '节目内容（节目内容限200字）',
                  // contentPadding: EdgeInsets.all(10),
                  border: InputBorder.none,
                  filled: true,
                ),
                focusNode: content_FocusMode,
                controller: content_Controller,
                inputFormatters: [LengthLimitingTextInputFormatter(200)],
                maxLines: 9,
              ),
            ),
            Flexible(
              child: buildGridView(),
            ),
            Row(
              children: <Widget>[
                Text('发布级别'),
                new Padding(
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        new Padding(
                          child: Text('普通'),
                          padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        ),
                        new Image.asset(
                          'images/next.png',
                          scale: 1.0,
                        )
                      ],
                    ),
                    onTap: () {
                      print('测试');
                    },
                  ),
                )
              ],
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            Row(
              children: <Widget>[
                Text('发布类型'),
                new Padding(
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        new Padding(
                          child: Text('非定时'),
                          padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        ),
                      ],
                    ),
                    onTap: () {
                      print('测试');
                    },
                  ),
                )
              ],
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            Row(
              children: <Widget>[
                Text('连续播放'),
                new Padding(
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        new Padding(
                          child: Text('1次'),
                          padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        ),
                        new Image.asset(
                          'images/next.png',
                          scale: 1.0,
                        )
                      ],
                    ),
                    onTap: () {
                      print('测试');
                    },
                  ),
                )
              ],
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            Row(
              children: <Widget>[
                Text('节目时长预估'),
                new Padding(
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        new Padding(
                          child: Text('普通'),
                          padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        ),
                      ],
                    ),
                    onTap: () {
                      print('测试');
                    },
                  ),
                )
              ],
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            Row(
              children: <Widget>[
                Text('发布设备'),
                new Padding(
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        new Padding(
                          child: Text('已选择了0个设备'),
                          padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        ),
                        new Image.asset(
                          'images/next.png',
                          scale: 1.0,
                        )
                      ],
                    ),
                    onTap: () {
                      print('测试');
                    },
                  ),
                )
              ],
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            Row(
              children: <Widget>[
                Text('存入工作区'),
                new Padding(
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        new Padding(
                          child: Text('默认工作区'),
                          padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        ),
                        new Image.asset(
                          'images/next.png',
                          scale: 1.0,
                        )
                      ],
                    ),
                    onTap: () {
                      print('测试');
                    },
                  ),
                )
              ],
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadAssets() async {
    setState(() {});
    List<Asset> resultList;
    String error;
    try {
      resultList =
          await MultiImagePicker.pickImages(maxImages: 300, enableCamera: true);
    } on PlatformException catch (e) {
      error = e.message;
      print("异常信息:" + error);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      if (resultList != null && resultList.isNotEmpty == true) {
        images.remove(_addPic);
        images.addAll(resultList);
        images.add(_addPic);
      }
    });
  }

  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        Widget add;
        if (index == images.length - 1) {
          add = new Image.asset(
            'images/addpic.png',
            scale: 1.5,
          );
        } else {
          add = AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          );
        }
        return InkWell(
          onTap: () {
            if (index == images.length - 1) {
              loadAssets();
            } else {
              print(
                  'do nothing!!!' + images[index].requestOriginal().toString());
            }
          },
          child: Card(
            child: add,
            elevation: 1,
          ),
        );
      }),
    );
  }
}
