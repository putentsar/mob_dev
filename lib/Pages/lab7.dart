import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter_mobile/widgets/bubble.dart';
import 'package:connectivity/connectivity.dart';

import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_mobile/main.dart';

class lab7 extends StatefulWidget {
  @override
  _lab7State createState() => _lab7State();
}

class _lab7State extends State<lab7> {
  TextEditingController _textFieldController = TextEditingController();
  ScrollController _scrollController = new ScrollController();

  List<BubbleWidget> bubbleWidgetsList = <BubbleWidget>[];

  final String backendURL = 'ws://51.15.91.29:8012';
  String statusMsg;
  bool isConnected;

  IO.Socket socket;

  _lab7State() {
    //конструктор
    statusMsg = 'Offline';
    isConnected = false;
    socket = IO.io(
        backendURL, IO.OptionBuilder().setTransports(['websocket']).build());
    connectAndListen();
  }

  String getCurrentTime() {
    DateTime currentDateTime = DateTime.now();
    int hour = currentDateTime.hour;
    int minute = currentDateTime.minute;
    String hourString = hour.toString();
    String minuteString = minute.toString();
    if (hour < 10) {
      hourString = '0${hour.toString()}';
    }
    if (minute < 10) {
      minuteString = '0${minute.toString()}';
    }
    return '$hourString:$minuteString';
  }

  String getTimeStringFromTimestamp(int timestamp) {
    DateTime currentDateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    int hour = currentDateTime.hour;
    int minute = currentDateTime.minute;
    String hourString = hour.toString();
    String minuteString = minute.toString();
    if (hour < 10) {
      hourString = '0${hour.toString()}';
    }
    if (minute < 10) {
      minuteString = '0${minute.toString()}';
    }
    return '$hourString:$minuteString';
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi);
  }

  void sendMessage() async {
    MyApp.analytics.logEvent(
        name: 'ButtonClick', parameters: {'ButtonName': 'ChatSendButton'});
    String message = _textFieldController.text;
    if (message.length > 0) {
      var timestamp = DateTime.now().millisecondsSinceEpoch;
      var data = {'text': message, 'time': timestamp};

      socket.emit('message', json.encode(data));
      setState(() {
        _textFieldController.text = '';
        bubbleWidgetsList.add(BubbleWidget(
            text: message,
            timeString: getCurrentTime(),
            isResponse: false,
            timestamp: timestamp));
      });
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  void connectAndListen() {
    socket.onConnect((_) {
      setState(() {
        statusMsg = 'Connected';
      });
    });

    socket.on('received', (data) {
      var received = json.decode(data);
      print(received);
      setState(() {
        for (int i = 0; i < bubbleWidgetsList.length; i++) {
          if (bubbleWidgetsList[i].getTimestamp == received['time']) {
            bubbleWidgetsList[i] = BubbleWidget(
              text: received['text'].toString(),
              timeString: getTimeStringFromTimestamp(received['time']),
              isResponse: false,
              isReceived: true,
              timestamp: received['time'],
            );
          }
        }
      });
    });

    socket.on('response', (data) {
      print('response: ' + data);
      var received = json.decode(data);
      bubbleWidgetsList.add(BubbleWidget(
        text: received['text'].toString(),
        timeString: getTimeStringFromTimestamp(received['time'] * 1000),
        isResponse: true,
        timestamp: received['time'] * 1000,
      ));
    });

    socket.onDisconnect((_) {
      setState(() {
        statusMsg = 'Reconnecting...';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            color: Colors.grey[200],
            child: Bubble(
              color: Color.fromRGBO(212, 234, 244, 1.0),
              child: Text(statusMsg,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11.0)),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              color: Colors.grey[200],
              child: ListView(
                controller: _scrollController,
                children: [
                  ...bubbleWidgetsList,
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 30,
                    width: 30,
                    // decoration: BoxDecoration(
                    //   color: Colors.lightBlue,
                    //   // borderRadius: BorderRadius.circular(30),
                    // ),
                    child: Icon(
                      Icons.add,
                      color: Colors.blue,
                      size: 24,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Flexible(
                  child: TextField(
                    controller: _textFieldController,
                    maxLines: 5,
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: "Write message...",
                      hintStyle: TextStyle(
                        color: Colors.black54,
                      ),
                      hintMaxLines: 2,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                FloatingActionButton(
                  onPressed: sendMessage,
                  child: Icon(
                    Icons.send,
                    color: Colors.blue,
                    size: 24,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  mini: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
