
import 'package:flutter/material.dart';
import 'package:sangyaw_app/model/person.dart';
import 'package:sangyaw_app/widgets/app_stateless_widget.dart';

typedef OnPersonSelectFunc = void Function(Person person);

class SelectPersonList extends AppStatelessWidget {
  List<Person> list;
  Map<int, bool> selectedMap;
  OnPersonSelectFunc onPersonSelect;
  SelectPersonList({this.list, this.selectedMap, this.onPersonSelect});

  @override
  Widget buildBody(BuildContext context) {
    return ListView(padding: EdgeInsets.zero,
      children: getWidgets(context)
    );
  }

  List<Widget> getWidgets(context) {
    List<Widget> arr =  <Widget>[];

    list.forEach((person) {

      arr.add(personTile(person, onTap: () {
        if(this.onPersonSelect != null) {
          this.onPersonSelect(person);
        }
      }));
//      arr.add(getLine());
    });
    return arr;

  }

  Widget getLine() {
    return SizedBox(
      height: 0.8,
      child: Container(
        color: Colors.grey,
      ),
    );
  }

  Widget personTile(Person person, {Function onTap}) {
    Icon ico = Icon(this.selectedMap[person.id] != null && this.selectedMap[person.id] ? Icons.check_box : Icons.check_box_outline_blank );
    Widget tile = ListTile(
      leading: IconButton(icon: ico, onPressed: onTap,) ,
      title: Text('${person.id} - ${person.facebookName}'),
      trailing:
          new Container(
            width: 120,
            height: 120,
            child:
              person.imageSmall,
//             Image.asset(setImagePath(person), fit: BoxFit.fitHeight),
         ),
      subtitle: Text('Address: ${person.address}, Assigned To: ${person.assignedTo}, Gender: ${person.gender}'),
      onTap: onTap,
    );
    return Card(child: tile, );
  }
}

String setImagePath(Person person) {
  String path;
  // if (person.profileImage.isNotEmpty) {
  //   path = person.profileImage;
  // }
  // else {
  //   path = "assets/images/dog.jpeg";
  //   print('showing image here');
  // }
  path = "assets/images/sample.png";

  return path;
}