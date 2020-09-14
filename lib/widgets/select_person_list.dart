import 'package:flutter/material.dart';
import 'package:sangyaw_app/model/person.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

import 'app_stateful_widget.dart';

typedef OnAssignToFunc = void Function(String assignTo, List<int> personIds);

class SelectPersonList extends StatefulWidget {
  List<Person> list;
  OnAssignToFunc onAssignTo;
  // Map<int, Person> selectedMap;
  // OnSelectionChange onSelectionChange;

  SelectPersonList({this.list, this.onAssignTo});

  @override
  _SelectPersonList createState() =>
      _SelectPersonList(list: this.list, onAssignTo: this.onAssignTo);
}

// ignore: must_be_immutable
class _SelectPersonList extends AppStatefulWidget<SelectPersonList> {
  List<Person> list;
  Map<int, Person> selectedMap;
  OnAssignToFunc onAssignTo;
  _SelectPersonList({this.list, this.selectedMap, this.onAssignTo});
  GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<String>>();
  String assignTo;
  String assignError;
  AutoCompleteTextField<String> textField;
  @override
  void initState() {
    super.initState();
    setState(() {
      assignTo = '';
      assignError = '';
      selectedMap = {};
    });
  }

  selectPerson(Person p) {
    Map<int, Person> map = Map<int, Person>.from(this.selectedMap);
    if (map[p.id] == null) {
      map[p.id] = p;
    } else {
      map.remove(p.id);
    }

    setState(() {
      this.selectedMap = map;
    });
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
    Icon ico = Icon(Icons.check_box_outline_blank);
    if (this.list.length == selectedMap.length) {
      ico = Icon(Icons.check_box);
    }
    if (selectedMap.length >= 1 && selectedMap.length < this.list.length) {
      ico = Icon(Icons.indeterminate_check_box);
    }

    ListTile head = ListTile(
      leading: IconButton(
        icon: ico,
        tooltip: 'Toggle All Selections',
        onPressed: () {
          Map<int, Person> map = Map<int, Person>.from(this.selectedMap);
          if (this.list.length == selectedMap.length) {
            // all is selected, so unselect all
            map.clear();
          } else if (selectedMap.length >= 1 &&
              selectedMap.length < this.list.length) {
            // atleast 1 is selected, so unselect all
            map.clear();
          } else {
            // nothing is selected so, select all
            this.list.forEach((p) {
              map[p.id] = p;
            });
          }

          setState(() {
            this.selectedMap = map;
          });
        },
      ),
      title: Text(
          'Selected ${this.selectedMap.length} of ${this.list.length} Persons'),
    );
    return this.decoratedContainer(head);
  }

  Widget getFooter() {
    Icon ico = Icon(Icons.send);
    IconButton submit;
    submit = IconButton(
      icon: ico,
      onPressed: () {
        if (this.selectedMap.length == 0) {
          textField.updateDecoration(
              decoration: getAutoCompleteDecoration(
                  submit, 'Cannot Assign, please select a person!!!'));
        } else {
          List<int> personIds = this.selectedMap.keys.toList();

          textField.updateDecoration(
              decoration: getAutoCompleteDecoration(submit, ''));
          this.onAssignTo(this.assignTo, personIds);
        }
      },
    );

    List<String> suggestions = this.dc.assignToList;
    this.textField = new AutoCompleteTextField<String>(
        decoration: getAutoCompleteDecoration(submit, ''),
        itemSubmitted: (item) {
          print('The Item is submitted: $item, assignto: $assignTo');
          setState(() {
            this.assignTo = item;
          });
        },
        controller: TextEditingController(text: this.assignTo),
        key: key,
        suggestions: suggestions,
        textChanged: (text) {
          setState(() {
            this.assignTo = text;
          });
        },
        itemBuilder: (context, suggestion) => new Padding(
            child: new ListTile(
              title: new Text(suggestion),
            ),
            padding: EdgeInsets.all(8.0)),
        // itemSorter: (a, b) => a.toLowerCase().compareTo(b.toLowerCase()),
        itemFilter: (suggestion, input) {
          return suggestion.toLowerCase().contains(input.toLowerCase());
        });

    return this.decoratedContainer(textField);
  }

  InputDecoration getAutoCompleteDecoration(IconButton submit, String error) {
    return new InputDecoration(
      prefix: new Icon(Icons.assignment_ind),
      hintText: "  Assign All Selected To:",
      contentPadding: EdgeInsets.all(8.0),
      errorText: error != '' ? error : null,
      suffix: submit,
    );
  }

  Widget getContents(BuildContext context) {
    Column contents = Column(
      children: buildPersonListsWidgets(context),
    );
    return contents;
  }

  List<Widget> buildPersonListsWidgets(context) {
    List<Widget> arr = <Widget>[];

    list.forEach((person) {
      arr.add(getPersonCard(person, onTap: () {
        this.selectPerson(person);
      }));
//      arr.add(getLine());
    });
    return arr;
  }

  Widget getPersonCard(Person person, {Function onTap}) {
    Icon ico = Icon(this.selectedMap[person.id] != null
        ? Icons.check_box
        : Icons.check_box_outline_blank);
    Widget tile = ListTile(
      leading: IconButton(
        icon: ico,
        onPressed: onTap,
      ),
      title: Text('${person.id} - ${person.facebookName}'),
      trailing: new Container(
        width: 120,
        height: 120,
        child: person.imageSmall,
      ),
      subtitle: Text(
          'Address: ${person.address}, Assigned To: ${person.assignedTo}, Gender: ${person.gender}'),
      onTap: onTap,
    );
    return Card(
      child: tile,
    );
  }
}
