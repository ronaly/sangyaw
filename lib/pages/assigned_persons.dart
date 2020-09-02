import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/widgets/person_list.dart';

class AssignedPersons extends AppStatelessLayoutContainer {

  @override
  String getTitle(context, AppState state) {
    return '${this.dc.currentDirectory} > Assigned To: ${this.dc.currentAssigned} ';
  }

  Widget buildBody(context, AppState state) {

    // START BODY HERE
    Widget body = PersonList(list: this.dc.findPersonsAssignedTo(this.dc.currentAssigned));

    // END/RETURN The body
    return body;
  }
}