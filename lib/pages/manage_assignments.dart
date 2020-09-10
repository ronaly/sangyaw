import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';

// ignore: must_be_immutable
class ManageAssignments extends AppStatelessLayoutContainer {
  String theText = 'Manangyaw ta tanan atong sangyawan :)';

  @override
  String getTitle() {
    return 'Manage Assignments';
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

  Widget getButtons(context) {
    return Column(
        children: <Widget> [
            this.buttonWidget(Icon(Icons.list), 'Manage All Persons', () => Navigator.pushNamed(context, '/manage_assignments_all')),
            this.buttonWidget(Icon(Icons.assignment), 'Manage by Assignment', () => Navigator.pushNamed(context, '/manage_assignments_by_assignments')),

            this.buttonWidget(Icon(Icons.terrain), 'Manage by Territory', () => Navigator.pushNamed(context, '/manage_assignments_by_territories')),
          ]
        );

  }

  @override
  Widget buildBody(context, AppState state) {

    Widget contents = Container (
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: getButtons(context),
    );

    return expandableContainer(null, contents, null);

  }
}