import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_mobile/Pages/lab5.dart';
import 'package:http/http.dart' as http;

class lab4 extends StatefulWidget {
  @override
  _lab4State createState() => new _lab4State();
}

class _lab4State extends State<lab4> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  StreamSubscription _onDestroy;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  String accessToken = '';
  String userId = '';

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.close();

    // Add a listener to on destroy WebView, so you can make came actions.
    // _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
    //   print("destroy");
    // });

    // _onStateChanged =
    //     flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
    //   print("onStateChanged: ${state.type} ${state.url}");
    // });

    // Add a listener to on url changed

    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        getAccessToken(url);
        getUserId(url);
      }
    });
  }

  getAccessToken(String url) {
    setState(() {
      print("URL changed: $url");
      if (url.contains('access_token=')) {
        RegExp regExpToken = new RegExp("#access_token=([A-z0-9]*)");
        this.accessToken = regExpToken.firstMatch(url)?.group(1);
        print("token $accessToken");
      }
    });
  }

  getUserId(String url) {
    setState(() {
      print("URL changed: $url");
      if (url.contains('user_id=')) {
        RegExp regExpUserId = new RegExp("user_id=([0-9]*)");
        this.userId = regExpUserId.firstMatch(url)?.group(1);
        print('USER_ID = $userId');
        flutterWebviewPlugin.dispose();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String loginUrl =
        "https://oauth.vk.com/authorize?client_id=7824991&response_type=token&display=page&redirect_uri=https://oauth.vk.com/blank.html";
    return new WebviewScaffold(
      url: loginUrl,
      appBar: new AppBar(
        title: new Text("MobDev"),
      ),
      withZoom: true,
      withLocalStorage: true,
      withJavascript: true,
      bottomNavigationBar: Padding(
        child: Text('Токен: ' + accessToken),
        padding: EdgeInsets.all(12),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          child: Text('Друзья'),
          onPressed: () {
            if (!(accessToken.isEmpty && userId.isEmpty)) {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          lab5(accessToken: accessToken, userId: userId)));
            }
          },
        ),
        ElevatedButton(
          child: Text('Сбросить Cookies'),
          onPressed: () {
            flutterWebviewPlugin.cleanCookies();
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          child: Text('Назад'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
