import 'package:flutter/material.dart';
import 'package:sangyaw_app/utils/app_script_utils.dart';
import 'package:sangyaw_app/widgets/app_stateless_widget.dart';
import 'package:sangyaw_app/widgets/input_dialog.dart';

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
    var congregationList = this.dc.congregationList;
    congregationList.keys.forEach((key) {
      var congregation = congregationList[key];
      String title = congregation.folderName;
      ListTile tile = ListTile(
        leading: Icon(congregation.crypt != null ? Icons.lock : Icons.settings),
        title: Text(title),
        trailing: congregation.folderId == this.dc.globals.congregation
            ? Icon(Icons.check)
            : null,
        onTap: () {
          if (congregation != this.dc.globals.congregation) {
            if (this.dc.globals.hasStoredPasswordAndMatch(
                congregation.folderId, congregation.crypt)) {
              this.dc.globals.congregation = congregation.folderId;
              this.dc.loadSettings();
              Navigator.pushNamed(this.context, '/');
            } else {
              InputDialog.show(this.context, (password) {
                String crypt = AppScriptUtils.encrypt(password);
                if (crypt == congregation.crypt) {
                  this
                      .dc
                      .globals
                      .setCongregationPassword(congregation.folderId, password);

                  this.dc.globals.congregation = congregation.folderId;
                  this.dc.loadSettings();
                  Navigator.pushNamed(this.context, '/');
                } else {
                  // TODO: message here
                }
              }, 'Password', 'Please enter the password');
            }
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
