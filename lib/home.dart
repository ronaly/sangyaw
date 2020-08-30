import 'package:flutter/material.dart';
import 'package:sangyaw_app/drawer_menu.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sangyaw_app/model/app_state.dart';

const kAppTitle = 'State by Redux';

class Home extends StatelessWidget {
  String text = 'the quick brown fox';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kAppTitle),
        backgroundColor: Colors.teal,
      ),
      drawer: DrawerMenu(),
      body: Container(
        margin: EdgeInsets.all(10),
        child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            return RichText(
              text: TextSpan(
                text: text,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: state.currentWorkbook == text ? FontWeight.bold : FontWeight.normal,
                  fontStyle: state.currentWorkbook == text ? FontStyle.italic : FontStyle.normal,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}