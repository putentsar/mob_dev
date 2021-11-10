import 'package:flutter/material.dart';
import 'package:flutter_mobile/Pages/lab4.dart';

class lab4page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => lab4pageState();
}

class lab4pageState extends State<lab4page> {
  final loginVkView = lab4();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      child: Column(
        children: [
          Text(
            'ЛР №4. oAuth2',
            textScaleFactor: 2,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
              child: Center(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => loginVkView));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Авторизация',
                        textScaleFactor: 1,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                )),
          )),
        ],
      ),
    );
  }
}
