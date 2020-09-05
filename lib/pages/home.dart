import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:sangyaw_app/model/person.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';

class Home extends AppStatelessLayoutContainer {
  String theText = 'Manangyaw ta tanan atong sangyawan :)';
  DefaultCacheManager manager = new DefaultCacheManager();

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
          this.buttonWidget(Icon(Icons.refresh), 'Refresh Data', () => this.dc.reloadMasterList()),
          this.buttonWidget(Icon(Icons.clear_all), 'Clear Image Cache', () => manager.emptyCache()),
          this.buttonWidget(Icon(Icons.list), 'All Persons', () => Navigator.pushNamed(context, '/all')),
          this.buttonWidget(Icon(Icons.assignment), 'Assignments', () => Navigator.pushNamed(context, '/assignments')),

          this.buttonWidget(Icon(Icons.terrain), 'Territories', () => Navigator.pushNamed(context, '/territories')),
          this.buttonWidget(Icon(Icons.add_a_photo), 'Territories', (){
            this.dc.currentPerson = Person.createEmpty();
            Navigator.pushNamed(context, '/edit_person');
          }),

        ],
      ),
    );
  } //widget button



}
