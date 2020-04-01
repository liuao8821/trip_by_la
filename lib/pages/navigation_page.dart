import 'package:flutter/material.dart';
import 'package:tripbyla/pages/speak_page.dart';
import 'package:tripbyla/uitl/navigator_util.dart';
import 'package:url_launcher/url_launcher.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  bool showClear = false;
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 25, right: 25),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                      blurRadius: 1.0, //阴影模糊程度
                      spreadRadius: 0.5 //阴影扩散程度
                      )
                ],
//          gradient: LinearGradient(
//            //AppBar渐变遮罩背景
//            colors: [Colors.white, Colors.transparent],
//            begin: Alignment.topCenter,
//            end: Alignment.bottomCenter,
//          ),
              ),
              child: Row(
                children: <Widget>[
                  Icon(Icons.search, size: 30, color: Color(0xffA9A9A9)),
                  Expanded(
                      flex: 1,
                      child: TextField(
                          controller: _controller,
                          onChanged: _onChanged,
                          autofocus: true,
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w300),
                          //输入文本的样式
                          decoration: InputDecoration(
                            contentPadding:
                                //flutter sdk >= v1.12.1 输入框样式适配
                                EdgeInsets.only(left: 5, bottom: 6, right: 5),
                            border: InputBorder.none,
                            hintText: '目的地',
                            hintStyle: TextStyle(fontSize: 20,color: Colors.white),
                          ))),
                  !showClear
                      ? _wrapTap(
                          Icon(
                            Icons.mic,
                            size: 30,
                            color: Colors.blue,
                          ),
                          _jumpToSpeak)
                      : _wrapTap(
                          Icon(
                            Icons.clear,
                            size: 30,
                            color: Colors.grey,
                          ), () {
                          setState(() {
                            _controller.clear();
                          });
                          _onChanged('');
                        }),
                  VerticalDivider(
                    indent: 5,
                    endIndent: 5,
                    thickness: 2,
                    width: 5,
                    color: Colors.black38,
                  ),
                  InkWell(
                    onTap: (){
                      _launchURL(_controller.text);
                    },
                    child: Padding(padding: EdgeInsets.all(2),
                    child: Text('搜索',style: TextStyle(fontSize: 20)),
                    ),
                  ),

                ],
              ),
            ),

          ),
        )
    );
  }

  _wrapTap(Widget child, void Function() callback) {
    return GestureDetector(
      onTap: () {
        if (callback != null) callback();
      },
      child: child,
    );
  }

  _onChanged(String text) {
    if (text.length > 0) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
//    if (widget.onChanged != null) {
//      widget.onChanged(text);
//    }
  }

  _jumpToSpeak() {
    NavigatorUtil.push(context, SpeakPage());
  }

  _launchURL(String destination) async {
    var url = 'baidumap://map/direction?'
        'region=beijing'
        '&destination=$destination'
        '&coord_type=bd09ll'
        '&mode=driving'
        '&src=andr.baidu.openAPIdemo';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
