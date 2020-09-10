import 'package:flutter/material.dart';
import 'package:sangyaw_app/model/person.dart';
import 'package:sangyaw_app/widgets/app_stateful_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/widgets/select_person_list.dart';



class ManageAssignmentsAllPersons extends StatefulWidget {
  @override
  _ManageAssignmentsAllPersons createState() => new _ManageAssignmentsAllPersons();
}



class _ManageAssignmentsAllPersons extends  AppStatefulLayoutContainer<ManageAssignmentsAllPersons>  {

  Map<int, Person> selectedMap;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedMap = {};
    });
  }

  @override
  String getTitle() {
    return 'Manage Assignments, All ${this.dc.totalPersons} Person[s]';
  }

  onSelectionChange(Map<int, Person> selectedChanges) {
    setState(() {
      this.selectedMap = selectedChanges;
    });
  }


  Widget buildBody(context, AppState state) {

    // START BODY HERE
    Widget body = SelectPersonList(list: this.dc.persons, selectedMap: this.selectedMap,onSelectionChange: this.onSelectionChange, );

    return body;
    // END/RETURN The body
  }
}