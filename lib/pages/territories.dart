
import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/widgets/app_stateful_layout_container.dart';



class Territories extends AppStatelessLayoutContainer {

  @override
  String getTitle(context, AppState state) {
    return '${this.dc.currentDirectory} Territories:';
  }


  Widget buildBody(context, AppState state) {
    List<Widget> arr =  <Widget>[];
    this.dc.addressList.forEach((territory) {
      String name = territory == null || territory == '' ? '- Uncategorized -' : territory;
      arr.add(ListTile(
          leading: Icon(Icons.terrain),
          title: Text(name),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            this.dc.currentAssigned = territory;
            Navigator.pushNamed(context, '/territory_persons');
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