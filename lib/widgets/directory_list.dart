import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_stateless_widget.dart';

// ignore: must_be_immutable
class DirectoryList extends AppStatelessWidget {
  Widget buildBody(BuildContext context) {
    List<Widget> arr = <Widget>[];

    arr.add(ListTile(
      leading: Icon(Icons.call_to_action),
      trailing: IconButton(
        icon: Icon(Icons.sync),
        onPressed: () {
          this.dc.loadSettings();
        },
      ),
      title: Text('Reload Directory List:'),
    ));

    arr.add(SizedBox(
      height: 0.5,
      child: Container(
        color: Colors.grey,
      ),
    ));

    this.dc.directories.forEach((directory) {
      String name =
          directory == null || directory == '' ? '- Unknown -' : directory;
      String title = name;
      ListTile tile = ListTile(
        leading: Icon(Icons.list),
        title: Text(title),
        trailing:
            directory == this.dc.currentDirectory ? Icon(Icons.check) : null,
        onTap: () {
          if (directory != this.dc.currentDirectory) {
            this.dataController.loadMasterList(directory);
            Navigator.pushNamed(context, '/');
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
