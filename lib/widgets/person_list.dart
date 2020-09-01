
import 'package:flutter/material.dart';
import 'package:sangyaw_app/model/person.dart';

class PersonList extends StatelessWidget {
  List<Person> list;
  PersonList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsets.zero,
      children: getWidgets(context)
    );
  }

  List<Widget> getWidgets(context) {
    List<Widget> arr =  <Widget>[];

    list.forEach((person) {

      arr.add(personTile(person, onTap: () {
        // TODO: implement callback here with person as paramater
        print('TODO: person click: ${person}');

        Navigator.pushReplacementNamed(context, '/person_details');
      }));
      arr.add(getLine());
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
    return ListTile(
      leading:
          new Container(
            width: 120,
            height: 120,
            child:
             Image.asset(setImagePath(person), fit: BoxFit.fitHeight),
         ),
      title: Text(person.facebookName),
      trailing: Icon(Icons.keyboard_arrow_right),
      subtitle: Text('Address: ${person.address}, Assigned To: ${person.assignedTo}, Gender: ${person.gender}'),
      onTap: onTap,
    );
  }
}

String setImagePath(Person person) {
  String path;
  if (person.profileImage.isNotEmpty) {
    path = person.profileImage;
  }
  else {
    path = "assets/images/dog.jpeg";
    print('showing image here');
  }

  return path;
}