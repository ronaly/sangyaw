import 'package:flutter/material.dart';
import 'package:sangyaw_app/model/person.dart';
import 'package:sangyaw_app/widgets/app_stateful_layout_container.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/widgets/person_list.dart';
import 'package:sangyaw_app/widgets/select_person_list.dart';



class BatchUpdateAllPersons extends StatefulWidget {
  @override
  _BatchUpdateAllPersons createState() => new _BatchUpdateAllPersons();
}



class _BatchUpdateAllPersons extends  AppStatefulLayoutContainer<BatchUpdateAllPersons>  {

  @override
  String getTitle(context, AppState state) {
    return 'Found ${this.dc.totalPersons} in ${this.dc.currentDirectory}';
  }

  onPersonSelect(Person p) {
    print('Person is selected');
    print(p);
  }


  Widget buildBody(context, AppState state) {

    // START BODY HERE
    Widget body = SelectPersonList(list: this.dc.persons, selectedMap: {20: true},onPersonSelect: this.onPersonSelect, );

    // END/RETURN The body
    return body;
  }
}