import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';
import 'package:sangyaw_app/widgets/show_photo_view.dart';
import 'package:sangyaw_app/widgets/custom_text_form_field.dart';
import 'package:sangyaw_app/model/person.dart';



class EditPerson extends AppStateLessLayoutContainer {
  final _formKey = GlobalKey<FormState>();


  @override
  String getTitle(context, AppState state) {
    String personName = this.dc.currentPerson.facebookName;
    return 'Edit $personName';
  }


  Widget buildBody (context, AppState appState) {
    return Container (
      child: editForm(context),

   );

  } //widget build

  Widget editForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView (
          children: ListTile.divideTiles(
            context: context,
            tiles: [
              ShowPhotoView(),
              Divider(),
              Padding( child: Text('Facebook Name:'),
              padding: EdgeInsets.all(5.0),),
              ListTile (
                title: CustomTextFormField(
                      hintText: 'Facebook Name:',
                      initialValue: this.dc.currentPerson.facebookName,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Facebook name cannot be empty.';}
                        return null; },
                      onSaved: (String value) { this.dc.currentPerson.facebookName = value;},
                  ),
                ),
              Padding( child: Text('Address:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                title: CustomTextFormField(
                  hintText: 'Address:',
                  initialValue: this.dc.currentPerson.address ,
                  onSaved: (String value) { this.dc.currentPerson.address = value;},
                ),
              ) ,
              Padding( child: Text('Gender:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                title: CustomTextFormField(
                  hintText: 'Gender:',
                  initialValue: this.dc.currentPerson.gender ,
                  onSaved: (String value) { this.dc.currentPerson.gender = value;},
                ),
              ) ,
              Padding( child: Text('Age Group:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                title: CustomTextFormField(
                  hintText: 'Age Group:',
                  initialValue: this.dc.currentPerson.ageGroup ,
                  onSaved: (String value) { this.dc.currentPerson.ageGroup = value;},
                ),
              ) ,
              Padding( child: Text('Messenger Status:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                title: CustomTextFormField(
                  hintText: 'Messenger Status:',
                  initialValue: this.dc.currentPerson.messengerStatus ,
                  onSaved: (String value) { this.dc.currentPerson.messengerStatus = value;},
                ),
              ) ,
              Padding( child: Text('Reference Details:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                title: CustomTextFormField(
                  hintText: 'Reference Details:',
                  initialValue: this.dc.currentPerson.referenceDetails ,
                  onSaved: (String value) { this.dc.currentPerson.referenceDetails = value;},
                ),
              ) ,
              Padding( child: Text('Assigned To:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                title: CustomTextFormField(
                  hintText: 'Assigned To:',
                  initialValue: this.dc.currentPerson.assignedTo ,
                  onSaved: (String value) { this.dc.currentPerson.assignedTo = value;},
                ),
              ) ,
              Padding( child: Text('Preached By:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                title: CustomTextFormField(
                  hintText: 'Preached By:',
                  initialValue: this.dc.currentPerson.preachedBy ,
                  onSaved: (String value) { this.dc.currentPerson.preachedBy = value;},
                ),
              ) ,
              Padding( child: Text('Date Contacted:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                title: CustomTextFormField(
                  hintText: 'Date Contacted:',
                  initialValue: this.dc.currentPerson.dateContacted ,
                  onSaved: (String value) { this.dc.currentPerson.dateContacted = value;},
                ),
              ) ,
              Padding( child: Text('Remarks:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                title: CustomTextFormField(
                  hintText: 'Remarks:',
                  initialValue: this.dc.currentPerson.remarks ,
                  onSaved: (String value) { this.dc.currentPerson.remarks = value;},
                ),
              ) ,
              Padding( child: Text('Progress Status:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                title: CustomTextFormField(
                  hintText: 'Progress Status:',
                  initialValue: this.dc.currentPerson.progressStatus ,
                  onSaved: (String value) { this.dc.currentPerson.progressStatus = value;},
                ),
              ) ,
              Container(child: saveButton(context)),
              Padding(padding: EdgeInsets.all(10.0)),
              Container(child: cancelButton(context)),
            ], //tiles []
          ).toList(), //ListTiles
        ), //ListView
    ); // Form

  } //listView

  Widget saveButton(BuildContext context) {
    return new Container (
      child: FloatingActionButton.extended (
        heroTag: null,
        onPressed: null, //() { Navigator.pushNamed(context, '/edit_person'); },
        tooltip: 'Save',
        icon: Icon(Icons.save),
        label: Text("Save"),
        shape: RoundedRectangleBorder(borderRadius:
        BorderRadius.all(Radius.circular(20.0))),
      ),
    );
  } //widget edit

  Widget cancelButton(BuildContext context) {
    return new Container (
      child: FloatingActionButton.extended (
        heroTag: null,
        onPressed: () async { Navigator.of(context).pop(); },
        tooltip: 'Cancel',
        icon: Icon(Icons.cancel),
        label: Text("Cancel"),
        shape: RoundedRectangleBorder(borderRadius:
        BorderRadius.all(Radius.circular(20.0))),
      ),
    );
  } //widget edit

} // class