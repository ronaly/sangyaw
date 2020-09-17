import 'package:flutter/material.dart';
import 'package:sangyaw_app/model/person.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';

// ignore: must_be_immutable
class Home extends AppStatelessLayoutContainer {
  String theText = 'Manangyaw ta tanan atong sangyawan :)';

  @override
  String getTitle() {
    return 'Home';
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
    return Wrap(children: <Widget>[
      // Icons: refresh sync, update
      this.buttonWidget(
          Icon(Icons.sync), 'Refresh Data', () => this.dc.reloadMasterList()),
//            this.buttonWidget(Icon(Icons.delete_sweep), 'Clear Image Cache', () => Navigator.pushNamed(context, '/clear_image_cache')),
      this.buttonWidget(Icon(Icons.list), 'All Persons',
          () => Navigator.pushNamed(context, '/all')),
      this.buttonWidget(Icon(Icons.assignment), 'Assignments',
          () => Navigator.pushNamed(context, '/assignments')),

      this.buttonWidget(Icon(Icons.terrain), 'Territories',
          () => Navigator.pushNamed(context, '/territories')),
      this.buttonWidget(Icon(Icons.person_add), 'Add Person', () {
        this.dc.currentPerson = Person.createEmpty();
        Navigator.pushNamed(context, '/edit_person');
      }), // Icons: group_work supervisor_account supervised_user_circle transfer_within_a_station
      this.buttonWidget(Icon(Icons.supervisor_account), 'Manage Assignments',
          () => Navigator.pushNamed(context, '/manage_assignments')),
      this.buttonWidget(Icon(Icons.settings), 'Settings',
          () => Navigator.pushNamed(context, '/settings')),
    ]);
  }

  @override
  Widget buildBody(context, AppState state) {
    return new Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: getButtons(context),
    );
  } //widget button

}
