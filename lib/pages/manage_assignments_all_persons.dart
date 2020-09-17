import 'package:flutter/material.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';
import 'package:sangyaw_app/widgets/select_person_list.dart';

import 'loading_dialog.dart';
import 'success_message.dart';

// ignore: must_be_immutable
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
