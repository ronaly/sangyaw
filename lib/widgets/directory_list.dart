import 'package:flutter/material.dart';
import 'package:sangyaw_app/pages/loading_dialog.dart';
import 'package:sangyaw_app/widgets/input_dialog.dart';
import 'package:sangyaw_app/utils/app_script_utils.dart';
import 'package:sangyaw_app/widgets/app_stateless_widget.dart';

// ignore: must_be_immutable
class DirectoryList extends AppStatelessWidget {
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
      title: Text('Directory List:'),
      subtitle: Text('Directory List for $congregationName'),
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
        leading: Icon(Icons.storage),
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

    arr.add(SizedBox(
      height: 0.5,
      child: Container(
        color: Colors.grey,
      ),
    ));

    arr.add(ListTile(
        // leading: Icon(Icons.build),
        trailing: IconButton(
          icon: Icon(Icons.create_new_folder),
          onPressed: () {
            InputDialog.show(context, (input) {
              this.createNewDirectory(input);
            }, 'Directory Name', 'Add New Directory');
          },
        ),
        title: Text('Add New'),
        subtitle: Text('Add New Directory for $congregationName')));

    arr.add(SizedBox(
      height: 0.5,
      child: Container(
        color: Colors.grey,
      ),
    ));

    return ListView(children: arr);
  }

  void createNewDirectory(String sheetName) {
    LoadingDialog.show(this.context);

    var folderId = this.dc.currentFolderId;
    AppScriptUtils.createSheet(folderId, sheetName).then((value) {
      print('This is the created test');
      print(value);
      LoadingDialog.hide(this.context);
      if (value['created'] == true) {
        this.dc.loadSettings();
      }
    }).catchError((onError) => LoadingDialog.hide(this.context));
  }
}
