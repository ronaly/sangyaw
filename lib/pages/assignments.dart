
import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/widgets/app_stateful_layout_container.dart';



class Assignments extends AppStatelessLayoutContainer {

  @override
  String getTitle(context, AppState state) {
    return 'Assignments:';
  }


  Widget buildBody(context, AppState state) {
    List<Widget> arr =  <Widget>[];
    this.dc.assignToList.forEach((preacher) {
      String name = preacher == null || preacher == '' ? '- Not Assigned -' : preacher;
      arr.add(ListTile(
          leading: Icon(Icons.assignment_ind),
          title: Text(name),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            this.dc.currentAssigned = preacher;
            Navigator.pushNamed(context, '/assigned_persons');
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