import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';
import 'package:sangyaw_app/widgets/show_photo_view.dart';
import 'package:sangyaw_app/utils/ui_utils.dart';

class PersonDetails extends AppStatelessLayoutContainer {


   var tilesInput = new Map();


   @override
  String getTitle() {
    return 'Person Details:';
  }


  Widget buildBody(context, AppState state) {

    tilesInput = {
      "Facebook Name: ":this.dc.currentPerson.facebookName,
      "Address: ":this.dc.currentPerson.address,
      "Gender: ":this.dc.currentPerson.gender,
      "Age Group: ":this.dc.currentPerson.ageGroup,
      "Messenger Status: ":this.dc.currentPerson.messengerStatus,
      "Reference Details: ":this.dc.currentPerson.referenceDetails,
      "Assigned To: ":this.dc.currentPerson.assignedTo,
      "Preached By: ":this.dc.currentPerson.preachedBy,
      "Date Contacted: ":this.dc.currentPerson.dateContacted.toString(),
      "Remarks: ":this.dc.currentPerson.remarks,
      "Progress Status: ":this.dc.currentPerson.progressStatus
    };


      return ListView(
        children: groupAllWidgets(tilesInput, context),

      );


  }  //build widget




  List<Widget> groupAllWidgets(Map list, context) {
     List<Widget> items = <Widget>[];
     items.add(ShowPhotoView());
     items.add(Divider());

     list.forEach((key, value) {
       if (key.toString().contains("Date")) {
          value = formatDateForDisplay(value.toString());
       }

       if (value.toString().isNotEmpty)
        items.add(getEachTile(key, value));

     });
    items.add(Divider());
    items.add(editButton(context));
    return items;
  }

  Widget getEachTile(String field, String value)
  {
    return ListTile(
      leading: rowField(field),
      title: rowValue(value),
    );

  }


  Widget rowField(String fieldName) {
    return Container (
        child: Text(fieldName,
            style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget rowValue(String fieldValue) {
    if (fieldValue.isEmpty) fieldValue = "";

      return Container (
        child: SelectableText("$fieldValue")
      );
  } //rowValue


   Widget editButton(BuildContext context) {
     return new Container (
       child: FloatingActionButton.extended (
         onPressed: () { Navigator.pushNamed(context, '/edit_person'); },
         tooltip: 'Edit',
         icon: Icon(Icons.edit),
         label: Text("Edit"),
         shape: RoundedRectangleBorder(borderRadius: 
                   BorderRadius.all(Radius.circular(20.0))),
       ),
     );
   } //widget edit


}  //class PersonDetails
