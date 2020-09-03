import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sangyaw_app/widgets/app_stateful_layout_container.dart';
import 'package:sangyaw_app/widgets/app_stateful_widget.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';
import 'package:sangyaw_app/widgets/photo_editor.dart';
import 'package:sangyaw_app/widgets/show_photo_view.dart';
import 'package:sangyaw_app/widgets/custom_text_form_field.dart';
import 'package:sangyaw_app/model/person.dart';
import 'package:sangyaw_app/widgets/custom_drop_down_button.dart';
import 'package:sangyaw_app/utils/ui_utils.dart';

class EditPerson extends StatefulWidget {
  _EditPerson createState() {
    return _EditPerson();
  }
}

//class _EditPerson extends AppStatefulLayoutContainer {

class _EditPerson extends AppStatefulLayoutContainer<EditPerson> {

  final _formKey = GlobalKey<FormState>();

  static int gender = 0;
  static int ageGroup = 1;
  static int messengerStatus = 2;
  static int progressStatus = 3;

  DateTime selectedDate =   DateTime.now();


  @override
  String getTitle(context, AppState state) {
    String personName = this.dc.currentPerson.facebookName;
    return 'Edit $personName';
  }

  @override
  Widget buildBody (context, AppState state) {
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
              PhotoEditor(),
              Divider(),
              Padding( child: Text('Facebook Name:'),
              padding: EdgeInsets.all(5.0),),
              ListTile (
                title: CustomTextFormField(
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
                  initialValue: this.dc.currentPerson.address ,
                  onSaved: (String value) { this.dc.currentPerson.address = value;},
                ),
              ) ,
              Padding( child: Text('Gender:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                // title: CustomTextFormField(
                //   initialValue: this.dc.currentPerson.gender ,
                //   onSaved: (String value) { this.dc.currentPerson.gender = value;},
                // ),
                  title: CustomDropDownButton(gender),


              ) ,
              Padding( child: Text('Age Group:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                // title: CustomTextFormField(
                //   initialValue: this.dc.currentPerson.ageGroup ,
                //   onSaved: (String value) { this.dc.currentPerson.ageGroup = value;},
                // ),
                title: CustomDropDownButton(ageGroup),
              ) ,
              Padding( child: Text('Messenger Status:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                // title: CustomTextFormField(
                //   initialValue: this.dc.currentPerson.messengerStatus ,
                //   onSaved: (String value) { this.dc.currentPerson.messengerStatus = value;},
                // ),
                title: CustomDropDownButton(messengerStatus),

              ) ,
              Padding( child: Text('Reference Details:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                title: CustomTextFormField(
                  initialValue: this.dc.currentPerson.referenceDetails ,
                  onSaved: (String value) { this.dc.currentPerson.referenceDetails = value;},
                ),
              ) ,
              Padding( child: Text('Assigned To:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                title: CustomTextFormField(
                  initialValue: this.dc.currentPerson.assignedTo ,
                  onSaved: (String value) { this.dc.currentPerson.assignedTo = value;},
                ),
              ) ,
              Padding( child: Text('Preached By:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                title: CustomTextFormField(
                  initialValue: this.dc.currentPerson.preachedBy ,
                  onSaved: (String value) { this.dc.currentPerson.preachedBy = value;},
                ),
              ) ,
              Padding( child: Text('Date Contacted:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                title:  Text(formatDate(this.dc.currentPerson.dateContacted)),
                onTap: () =>  customShowDatePicker(context),
              ) ,
              Padding( child: Text('Remarks:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                title: CustomTextFormField(
                  initialValue: this.dc.currentPerson.remarks ,
                  onSaved: (String value) { this.dc.currentPerson.remarks = value;},
                ),
              ) ,
              Padding( child: Text('Progress Status:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                // title: CustomTextFormField(
                //   initialValue: this.dc.currentPerson.progressStatus ,
                //   onSaved: (String value) { this.dc.currentPerson.progressStatus = value;},
                //),

                title: CustomDropDownButton(progressStatus),

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
        onPressed: () {
          this.dc.savePerson(this.dc.currentPerson);
        }, //() { Navigator.pushNamed(context, '/edit_person'); },
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



  Future<void> customShowDatePicker(BuildContext context) async {

    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 1),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        this.dc.currentPerson.dateContacted = selectedDate.toString();
      });
    }
  }



} // class