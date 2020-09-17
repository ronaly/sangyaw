import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SuccessMessage extends StatelessWidget {
  String message;
  String route;
  SuccessMessage(this.message, this.route);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.send, size: 100),
            SizedBox(height: 10),
            Text(
              this.message,
              style: TextStyle(fontSize: 54, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            RaisedButton.icon(
              onPressed: () {
                Navigator.of(context).popAndPushNamed(this.route);
              },
              icon: Icon(Icons.check),
              label: Text('Ok'),
            ),
          ],
        ),
      ),
    );
  }
}
