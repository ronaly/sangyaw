import 'package:flutter/material.dart';
import 'package:sangyaw_app/model/person.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/widgets/person_list.dart';

// ignore: must_be_immutable
class TerritoryPersons extends AppStatelessLayoutContainer {

  int count;
  @override
  String getTitle() {
    return 'Assigned To: ${this.dc.currentAssigned} ($count)';
  }

  Widget buildBody(context, AppState state) {

    List<Person> list = this.dc.findPersonsByTerritory(this.dc.currentAssigned);
    count = list.length;

    // START BODY HERE
    Widget body = PersonList(list: list);

    // END/RETURN The body
    return body;
  }
}