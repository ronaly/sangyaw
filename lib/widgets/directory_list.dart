import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_stateless_widget.dart';

// ignore: must_be_immutable
class DirectoryList extends AppStatelessWidget {
  Widget buildBody(BuildContext context) {
    List<Widget> arr = <Widget>[];
    this.dc.directories.forEach((directory) {
      String name =
          directory == null || directory == '' ? '- Unknown -' : directory;
      String title = name;
      arr.add(ListTile(
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
