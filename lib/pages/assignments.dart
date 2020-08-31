
import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';

class Assignments extends AppLayoutContainer {

  @override
  String getTitle(context, AppState state) {
    return 'Please select to view assigned to:';
  }

  Widget buildBody(context, AppState state) {
    List<Widget> arr =  <Widget>[];
    this.dc.assignToList.forEach((preacher) {
      String name = preacher == null || preacher == '' ? '- Not Assigned -' : preacher;
      arr.add(ListTile(
          leading: Icon(Icons.assignment_ind_outlined),
          title: Text(name),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            print('Tapped: ${preacher}');
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