import 'package:flutter/material.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/model/person.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';
import 'package:sangyaw_app/widgets/select_person_list.dart';

import 'loading_dialog.dart';
import 'success_message.dart';

// ignore: must_be_immutable
class ManageAssignmentsByTerritoryPersons extends AppStatelessLayoutContainer {
  int count;
  @override
  String getTitle() {
    return 'Manage Assignments, Territory: ${this.dc.currentAssigned} ($count)';
  }

  Widget buildBody(context, AppState state) {
    List<Person> list = this.dc.findPersonsByTerritory(this.dc.currentAssigned);
    count = list.length;
    // START BODY HERE
    Widget body = SelectPersonList(
      list: list,
      onAssignTo: (assignTo, personIds) {
        LoadingDialog.show(context);
        this.dc.assignPersons(assignTo, personIds).then((value) {
          LoadingDialog.hide(context);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => SuccessMessage(
                  'Assignment Update Success!', '/manage_assignments')));
        });
      },
    );

    return body;
    // END/RETURN The body
  }
}
