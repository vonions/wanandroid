import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  double lineProgress = 0.0;

  _DetailPage(this.title, this.link);

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.onProgressChanged.listen((progress) {
      print(progress);
      setState(() {
        lineProgress = progress;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(title)
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
    flutterWebviewPlugin.dispose();
    super.dispose();
  }
}
