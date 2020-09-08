
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
    Widget contents = getContents(context);


    Container header = Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.blue,
      alignment: Alignment.center,
      child: Text("Header"),
    );

    Container footer = Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.blue,
      alignment: Alignment.center,
      child: Text("Footer"),
    );

    return SafeArea( child: Column(children: [header, contents, footer],),);
  }

  Expanded getContents(BuildContext context) {
     SingleChildScrollView inner = SingleChildScrollView(padding: EdgeInsets.zero,
        physics: ClampingScrollPhysics(),
        child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: buildPersonListsWidgets(context),
            ),

        ),
       );
     Expanded contents = Expanded(child: inner);
     return contents;
  }

  List<Widget> buildPersonListsWidgets(context) {
    List<Widget> arr =  <Widget>[];

    list.forEach((person) {

      arr.add(getPersonCard(person, onTap: () {
        if(this.onPersonSelect != null) {
          this.onPersonSelect(person);
        }
      }));
//      arr.add(getLine());
    });
    return arr;

  }


  Widget getPersonCard(Person person, {Function onTap}) {
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
         ),
      subtitle: Text('Address: ${person.address}, Assigned To: ${person.assignedTo}, Gender: ${person.gender}'),
      onTap: onTap,
    );
    return Card(child: tile, );
  }
}
