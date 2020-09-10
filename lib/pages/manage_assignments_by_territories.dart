
import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';



// ignore: must_be_immutable
class ManageAssignmentsByTerritories extends AppStatelessLayoutContainer {

  @override
  String getTitle() {
    return 'Select Assignments by Territory';
  }


  Widget buildBody(context, AppState state) {
    List<Widget> arr =  <Widget>[];
    this.dc.addressList.forEach((territory) {
      String name = territory == null || territory == '' ? '- Uncategorized -' : territory;
      String title = '$name (${this.dc.countPersonsByTerritory(territory.toLowerCase())})';
      arr.add(ListTile(
          leading: Icon(Icons.terrain),
          title: Text(title),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            this.dc.currentAssigned = territory;
            Navigator.pushNamed(context, '/batch_update_by_territory_persons');
          },
      ));
      arr.add(SizedBox(
        height: 0.5,
        child: Container(
          color: Colors.grey,
        ),
      ));
    });
    return ListView(children: arr);
  }
}