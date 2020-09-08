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

  Map<int, bool> selectedMap;

  @override
  void initState() {
    setState(() {
      selectedMap = {};
    });
  }

  @override
  String getTitle(context, AppState state) {
    return 'Batch Update ${this.dc.totalPersons} Person[s] in ${this.dc.currentDirectory}';
  }

  onPersonSelect(Person p) {
    if(this.selectedMap[p.id] == null  || this.selectedMap[p.id] == false) {
      setState(() {
        this.selectedMap[p.id] = true;
      });
    } else {
      setState(() {
        this.selectedMap[p.id] = false;
      });
    }
  }


  Widget buildBody(context, AppState state) {

    // START BODY HERE
    Widget body = SelectPersonList(list: this.dc.persons, selectedMap: this.selectedMap,onPersonSelect: this.onPersonSelect, );

    // END/RETURN The body
    return body;
  }
}