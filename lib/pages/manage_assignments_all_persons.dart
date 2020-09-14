import 'package:flutter/material.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';
import 'package:sangyaw_app/widgets/select_person_list.dart';

class ManageAssignmentsAllPersons extends AppStatelessLayoutContainer {
  @override
  String getTitle() {
    return 'Manage Assignments, All ${this.dc.totalPersons} Person[s]';
  }

  Widget buildBody(context, AppState state) {
    // START BODY HERE
    Widget body = SelectPersonList(
      list: this.dc.persons,
      onAssignTo: (assignTo, personIds) {
        this.dc.assignPersons(assignTo, personIds);
      },
    );

    return body;
    // END/RETURN The body
  }
}
