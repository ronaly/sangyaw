import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:sangyaw_app/model/person.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';

class Home extends AppStatelessLayoutContainer {
  String theText = 'Manangyaw ta tanan atong sangyawan :)';

  @override
  String getTitle(context, AppState state) {
    if(this.dc.currentDirectory == null) {
      return 'Home';
    }
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

  Widget getButtons(context) {
    return Wrap(
        children: <Widget> [
            this.buttonWidget(Icon(Icons.refresh), 'Refresh Data', () => this.dc.reloadMasterList()),
//            this.buttonWidget(Icon(Icons.delete_sweep), 'Clear Image Cache', () => Navigator.pushNamed(context, '/clear_image_cache')),
            this.buttonWidget(Icon(Icons.list), 'All Persons', () => Navigator.pushNamed(context, '/all')),
            this.buttonWidget(Icon(Icons.assignment), 'Assignments', () => Navigator.pushNamed(context, '/assignments')),

            this.buttonWidget(Icon(Icons.terrain), 'Territories', () => Navigator.pushNamed(context, '/territories')),
            this.buttonWidget(Icon(Icons.person_add ), 'Add Person', (){
                this.dc.currentPerson = Person.createEmpty();
                Navigator.pushNamed(context, '/edit_person');
            })
          ]
        );

  }

  @override
  Widget buildBody(context, AppState state) {


    return new Container (
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: getButtons(context),
    );
  } //widget button



}
