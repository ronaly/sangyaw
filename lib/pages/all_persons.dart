import 'package:flutter/material.dart';
import 'package:sangyaw_app/model/person.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/widgets/person_list.dart';

// ignore: must_be_immutable
class AllPersons extends AppStatelessLayoutContainer {

  @override
  String getTitle() {
    return 'Total of ${this.dc.totalPersons} Persons';
  }

  onPersonSelect(Person p) {
    print('Person is selected');
    print(p);
  }


  Widget buildBody(context, AppState state) {

    // START BODY HERE
    Widget body = PersonList(list: this.dc.persons);

    // END/RETURN The body
    return body;
  }
}