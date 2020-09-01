import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sangyaw_app/widgets/app_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';


class PersonDetails extends AppLayoutContainer {

   final String netWorkImagePath = "https://drive.google.com/uc?export=view&id=1tuXRwIIBmPxJfv0ApLoptmdsZtzS9rpK";

  @override
  String getTitle(context, AppState state) {
    return 'Person Details:';
  }

  Widget buildBody(context, AppState state) {

    return Container (
         child: listView(context),
      );

  }  //build widget

  Widget photoView() {
    return  SizedBox(
        height: 400.0,
        child: Card (
        elevation: 5,
        child: ClipRect (
           child: Align (
              heightFactor: 0.5,
              child: PhotoView(
               // imageProvider: AssetImage("assets/images/sample.png"),
               // imageProvider: NetworkImage("$netWorkImagePath/akasya_images/Adriana Sanchez.Profile Image.073906.png"),
                imageProvider: NetworkImage(netWorkImagePath),
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.contained * 5.8,
                basePosition: Alignment.center,
              ),
          ),
        ),
       )
    );
  } //photoView


  Widget listView(BuildContext context) {
    return ListView (
          children: ListTile.divideTiles(
            context: context,
            tiles: [
              photoView(),
              ListTile (
                leading: rowField("Facebook Name: "),
                title: rowValue(this.dc.currentPerson.facebookName),
              ) ,
              ListTile (
                leading: rowField("Address: "),
                title: rowValue(this.dc.currentPerson.address),
              ) ,
              ListTile (
                leading: rowField("Gender: "),
                title: rowValue(this.dc.currentPerson.gender),
              ) ,
              ListTile (
                leading: rowField("Age Group: "),
                title: rowValue(this.dc.currentPerson.ageGroup),
              ) ,
              ListTile (
                leading:  rowField("Messenger Status: "),
                title: rowValue(this.dc.currentPerson.messengerStatus),
              ) ,
              ListTile (
                leading:  rowField("Reference Details: "),
                title: rowValue(this.dc.currentPerson.referenceDetails),
              ) ,
              ListTile (
                leading:  rowField("Assigned To: "),
                title: rowValue(this.dc.currentPerson.assignedTo),
              ) ,
              ListTile (
                leading:  rowField("Preached By: "),
                title: rowValue(this.dc.currentPerson.preachedBy ),
              ) ,
              ListTile (
                leading:  rowField("Date Contacted: "),
                title: rowValue(formatDate(this.dc.currentPerson.dateContacted)),
              ) ,
              ListTile (
                leading:  rowField("Remarks: "),
                title:  rowValue(this.dc.currentPerson.remarks),
              ) ,
              ListTile (
                leading:   rowField("Progress Status: "),
                title:  rowValue(this.dc.currentPerson.progressStatus),
              ) ,
            ], //tiles []
          ).toList(), //ListTiles
        ); //ListView
  } //listView


  Widget rowField(String fieldName) {
    return Container (
        child: Text(fieldName,
            style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget rowValue(String fieldValue) {
    if (fieldValue.isEmpty) fieldValue = "";

      return Container (
        child: Text("$fieldValue")
      );
  } //rowValue

   formatDate (var strDate) {
     var formatter = new DateFormat('MM-dd-yyyy');
     var parDate = DateTime.parse(strDate);
     var newDate;
     if (strDate != null ) newDate = formatter.format(parDate);
     return newDate;
  } //formatDate


}  //class PersonDetails
