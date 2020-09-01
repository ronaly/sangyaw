import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:photo_view/photo_view.dart';

class PersonDetails extends AppLayoutContainer {

  @override
  String getTitle(context, AppState state) {
    return 'Person Details:';
  }

  Widget buildBody(context, AppState state) {

    return Column   (
      crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          SizedBox(
              height: 150.0,
              width: 200,
              child: Card (
                elevation: 5,
                child: Container (
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  height: 300.0,
                  child: PhotoView(
                    imageProvider: AssetImage("assets/images/sample.png"),
                  ),

                )
              )
          ),

      Divider(),
      Row (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            rowField("Facebook Name: "),
            rowValue(this.dc.currentPerson.facebookName),
      ], ),
      Divider(),
          Row (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              rowField("Address: "),
              rowValue(this.dc.currentPerson.address),
            ], ),
       Divider(),
          Row (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                rowField("Gender: "),
                rowValue(this.dc.currentPerson.gender),
            ], ),
          Divider(),
          Row (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              rowField("Age Group: "),
              rowValue(this.dc.currentPerson.ageGroup),
            ], ),
          Divider(),
          Row (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              rowField("Messenger Status: "),
              rowValue(this.dc.currentPerson.messengerStatus),
            ], ),
           Divider(),
           Row (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              rowField("Reference Details: "),
              rowValue(this.dc.currentPerson.referenceDetails),
             ], ),
          Divider(),
          Row (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              rowField("Assigned To: "),
              rowValue(this.dc.currentPerson.assignedTo),
            ], ),
          Divider(),
          Row (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              rowField("Preached By: "),
              rowValue(this.dc.currentPerson.preachedBy),
            ], ),
          Divider(),
          Row (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              rowField("Date Contacted: "),
              rowValue(this.dc.currentPerson.dateContacted),
            ], ),
          Divider(),
          Row (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              rowField("Remarks: "),
              rowValue(this.dc.currentPerson.remarks),
            ], ),
          Divider(),
          Row (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              rowField("Progress Status: "),
              rowValue(this.dc.currentPerson.progressStatus),
          ],)
    ],
    );
  }  //build widget


  Widget rowField(String fieldName) {
    return Container (
        child: Text("$fieldName"),
    );
  }

  Widget rowValue(String fieldValue) {
    if (fieldValue.isEmpty) fieldValue = "";

    return Expanded (
        //padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text("$fieldValue")


      );

  }


}  //class PersonDetails
