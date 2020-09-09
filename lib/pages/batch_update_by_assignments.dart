
import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';



// ignore: must_be_immutable
class BatchUpdateByAssignments extends AppStatelessLayoutContainer {

  @override
  String getTitle() {
    return 'Batch Update By Assignments:';
  }


  Widget buildBody(context, AppState state) {
    List<Widget> arr =  <Widget>[];
    this.dc.assignToList.forEach((preacher) {
      String name = preacher == null || preacher == '' ? '- Not Assigned -' : preacher;
      String title = '$name (${this.dc.countPersonsAssignedTo(preacher.toLowerCase())})';
      arr.add(ListTile(
          leading: Icon(Icons.assignment_ind),
          title: Text(title),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            this.dc.currentAssigned = preacher;
            Navigator.pushNamed(context, '/batch_update_assigned_persons');
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