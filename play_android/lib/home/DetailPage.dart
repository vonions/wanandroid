import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class DetailPage extends StatefulWidget {
  String title;
  String link;

  DetailPage(this.title, this.link);

  @override
  State<StatefulWidget> createState() {
    return _DetailPage(title, link);
  }
}

class _DetailPage extends State<DetailPage> {
  String title;
  String link;
  FlutterWebviewPlugin flutterWebViewPlugin = FlutterWebviewPlugin();
  double lineProgress = 0.0;

  _DetailPage(this.title, this.link);

  StreamSubscription<String> _onUrlChanged;
  @override
  void initState() {
    super.initState();

    flutterWebViewPlugin.close();

    _onUrlChanged =
        flutterWebViewPlugin.onUrlChanged.listen((String url) async {
          if (url.contains('weixin:') || url.contains('alipay:')) {
            await flutterWebViewPlugin.stopLoading();
            await flutterWebViewPlugin.goBack();
//            if (await canLaunch(url)) {
//              await launch(url);
//            } else {
//              throw 'Could not launch $url';
//            }
          }
        });
    flutterWebViewPlugin.onProgressChanged.listen((progress) {
      print(progress);
      setState(() {
        lineProgress = progress;
      });
    });

    flutterWebViewPlugin.onUrlChanged.listen((String url) async {

      print('swtttt:'+url);
      if(url.startsWith("http")||url.startsWith("https")){

      }else{
        await flutterWebViewPlugin.stopLoading();
        await flutterWebViewPlugin.goBack();
//
        print("couldn't launch $url");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int num=(lineProgress*100).round();

    return WebviewScaffold(

      appBar: AppBar(
        title: Text(num==100?title:"(${num})%${title}")
      ),
      url: link,
      hidden: true,
    );
  }

  _progressBar(double progress, BuildContext context) {
    int num=(lineProgress*100).round();
    return Container(
      width: 100,
      height: 100,
      child: Text(num==100?"":"loading${num}%",style: TextStyle(color: Colors.white),),
    );
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    flutterWebViewPlugin.dispose();
    super.dispose();
  }
}
