import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'package:flutter_mobile/Pages/lab4page.dart';
import 'package:flutter_mobile/Pages/lab6.dart';
import 'package:flutter_mobile/Pages/lab7.dart';
import 'package:flutter_mobile/Pages/lab8.dart';

// void main() => runApp(const MyApp());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp() : super();

  static const String _title = 'Flutter Mobile Dev';
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    MyApp.analytics.logAppOpen();
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyHomePage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyHomePage extends StatelessWidget {
  const MyHomePage() : super();

  Future<void> _sendAnalyticsEvent(int pageNum) async {
    await MyApp.analytics.setCurrentScreen(screenName: 'Page #$pageNum');
    await MyApp.analytics.logEvent(
      name: 'page_change',
      parameters: <String, dynamic>{'page': pageNum},
    );
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return PageView(
      onPageChanged: (int pugeNum) async {
        await _sendAnalyticsEvent(pugeNum);
      },

      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
      /// Use [Axis.vertical] to scroll vertically.
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: <Widget>[
        lab4page(),
        lab6(),
        lab7(),
        lab8(),
        Center(
          child: Text('Third Page'),
        )
      ],
    );
  }
}
