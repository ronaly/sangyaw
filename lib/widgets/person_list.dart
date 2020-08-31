
import 'package:flutter/material.dart';
import 'package:sangyaw_app/model/person.dart';

class PersonList extends StatelessWidget {
  List<Person> list;
  PersonList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsets.zero,
      children: getWidgets()
    );
  }

  List<Widget> getWidgets() {
    List<Widget> arr =  <Widget>[];

    list.forEach((person) {

      arr.add(personTile(person, onTap: () {
        // TODO: implement callback here with person as paramater
        print('TODO: person click: ${person}');
      }));
      arr.add(getLine());
    });
    return arr;

  }

  Widget getLine() {
    return SizedBox(
      height: 0.5,
      child: Container(
        color: Colors.grey,
      ),
    );
  }

  Widget personTile(Person person, {Function onTap}) {
    return ListTile(
      leading: Icon(Icons.face_rounded),
      title: Text(person.facebookName),
      trailing: Icon(Icons.keyboard_arrow_right),
      subtitle: Text('Taga: ${person.address}, Gi Assign ni: ${person.assignedTo}, Gender: ${person.gender}'),
      onTap: onTap,
    );
  }
}