import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';

class Home extends AppStatelessLayoutContainer {
  String theText = 'Manangyaw ta tanan atong sangyawan :)';

  @override
  String getTitle(context, AppState state) {
    return '${this.dc.currentDirectory} Home:';
  }



  Widget buttonWidget(Icon icon, String caption, VoidCallback callback) {
    return Column(children: [
      IconButton(
        color: Colors.blueAccent,
        iconSize: 100.0,
        onPressed: callback,
        icon: icon,
        tooltip: caption,
      ),
      Text(caption),
    ]);
  }

  @override
  Widget buildBody(context, AppState state) {

    return new Container (
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Wrap(
        children: <Widget> [
          this.buttonWidget(Icon(Icons.list_alt), 'All Persons', () => Navigator.pushNamed(context, '/all')),
          this.buttonWidget(Icon(Icons.assignment_ind), 'Assignments', () => Navigator.pushNamed(context, '/assignments')),
          this.buttonWidget(Icon(Icons.terrain_rounded), 'Territories', () => Navigator.pushNamed(context, '/territories')),
        ],
      ),
    );
  } //widget button



}
