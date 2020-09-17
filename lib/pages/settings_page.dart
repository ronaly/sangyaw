import 'package:flutter/material.dart';
import 'package:sangyaw_app/utils/globals.dart';
import 'package:sangyaw_app/widgets/app_stateful_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPage createState() => new _SettingsPage();
}

class _SettingsPage extends AppStatefulLayoutContainer<SettingsPage> {
  @override
  String getTitle() {
    return 'My SangyawApp Settings:';
  }

  Widget buildBody(context, AppState state) {
    List<Widget> arr = <Widget>[];
    this.dc.congregationList.forEach((congregation) {
      String name = congregation == null || congregation == ''
          ? '- Unknown -'
          : congregation;
      String title = name;
      arr.add(ListTile(
        leading: Icon(Icons.settings),
        title: Text(title),
        trailing: Icon(Icons.check),
        onTap: () {
          Globals().congregation = congregation;
        },
      ));
      arr.add(SizedBox(
        height: 0.5,
        child: Container(
          color: Colors.grey,
        ),
      ));
    }); //end of forEach loop
    return ListView(children: arr);
  }
}
