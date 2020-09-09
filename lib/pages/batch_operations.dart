import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:sangyaw_app/model/person.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';

class BatchOperations extends AppStatelessLayoutContainer {
  String theText = 'Manangyaw ta tanan atong sangyawan :)';

  @override
  String getTitle() {
    return 'Batch Operations';
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
            this.buttonWidget(Icon(Icons.list), 'Batch Update All Persons', () => Navigator.pushNamed(context, '/batch_update_all')),
            this.buttonWidget(Icon(Icons.assignment), 'Batch Update By Assignment', () => Navigator.pushNamed(context, '/batch_update_by_assignments')),

            this.buttonWidget(Icon(Icons.terrain), 'Batch Update By Territory', () => Navigator.pushNamed(context, '/batch_update_by_territories')),
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