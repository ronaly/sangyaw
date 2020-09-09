
import 'package:flutter/material.dart';
import 'package:sangyaw_app/model/person.dart';
import 'package:sangyaw_app/widgets/app_stateless_widget.dart';

typedef OnSelectionChange = void Function(Map<int, Person> selectedChanges);

class SelectPersonList extends AppStatelessWidget {

  

  List<Person> list;
  Map<int, Person> selectedMap;
  OnSelectionChange onSelectionChange;
  SelectPersonList({this.list, this.selectedMap, this.onSelectionChange});

  

  selectPerson(Person p) {
    Map<int, Person> map = Map<int, Person>.from(this.selectedMap);
    if(map[p.id] == null) {
        map[p.id] = p;
    } else {
        map.remove(p.id);
    }

    this.onSelectionChange(map);
  }


  @override
  Widget buildBody(BuildContext context) {
    Widget contents = getContents(context);


    Widget header = getHeader();

    Widget footer = getFooter();

    return expandableContainer(header, contents, footer);

    // return SafeArea( child: Column(children: [header, contents, footer],),);
  }

  Widget getHeader() {
    Icon ico = Icon(Icons.check_box_outline_blank );
    if(this.list.length == selectedMap.length) {
      ico = Icon(Icons.check_box);
    }
    if(selectedMap.length >= 1 && selectedMap.length < this.list.length) {
      ico = Icon(Icons.indeterminate_check_box);
    }
    
    ListTile head =ListTile(
        leading: IconButton(icon: ico, tooltip: 'Toggle All Selections', onPressed: () {
          Map<int, Person> map = Map<int, Person>.from(this.selectedMap);
          if(this.list.length == selectedMap.length) {
            // all is selected, so unselect all
            map.clear();
          } else if(selectedMap.length >= 1 && selectedMap.length < this.list.length) {              
            // atleast 1 is selected, so unselect all
            map.clear();
          } else {
            // nothing is selected so, select all
            this.list.forEach((p) {
              map[p.id] = p;
            });
          }

          this.onSelectionChange(map);

        },),
        title: Text('Selected ${this.selectedMap.length} of ${this.list.length} Persons'),
      );
    return this.decoratedContainer(head);
  }



  Widget getFooter() {
    
    Container footer = this.decoratedContainer(Text("Footer"));
    return footer;
  }


  Widget getContents(BuildContext context) {
     Column contents = Column(
              children: buildPersonListsWidgets(context),
            );
     return contents;
  }

  List<Widget> buildPersonListsWidgets(context) {
    List<Widget> arr =  <Widget>[];

    list.forEach((person) {

      arr.add(getPersonCard(person, onTap: () {
        if(this.onSelectionChange != null) {
          this.selectPerson(person);
        }
      }));
//      arr.add(getLine());
    });
    return arr;

  }


  Widget getPersonCard(Person person, {Function onTap}) {
    Icon ico = Icon(this.selectedMap[person.id] != null ? Icons.check_box : Icons.check_box_outline_blank );
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
