import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_stateless_widget.dart';

// ignore: must_be_immutable
class SangyawAppSettings extends AppStatelessWidget {
  Widget buildBody(BuildContext context) {
    List<Widget> arr = <Widget>[];

    arr.add(ListTile(
      // leading: Icon(Icons.build),
      trailing: IconButton(
        icon: Icon(Icons.sync),
        onPressed: () {
          this.dc.loadSettings();
        },
      ),
      title: Text('Reload Congregations List:'),
    ));

    arr.add(SizedBox(
      height: 0.5,
      child: Container(
        color: Colors.grey,
      ),
    ));

    this.dc.congregationList.forEach((congregation) {
      String name = congregation == null || congregation == ''
          ? '- Unknown -'
          : congregation;
      String title = name;
      ListTile tile = ListTile(
        leading: Icon(Icons.settings),
        title: Text(title),
        trailing: congregation == this.dc.globals.congregation
            ? Icon(Icons.check)
            : null,
        onTap: () {
          if (congregation != this.dc.globals.congregation) {
            this.dc.globals.congregation = congregation;
            this.dc.loadSettings();
          }
        },
      );
      arr.add(Card(
        child: tile,
      ));
    }); //end of forEach loop
    return ListView(children: arr);
  }
}
