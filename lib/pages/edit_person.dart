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


class _EditPerson extends AppStatefulLayoutContainer<EditPerson> {

  final _formKey = GlobalKey<FormState>();


  static int gender = 0;
  static int ageGroup = 1;
  static int messengerStatus = 2;
  static int progressStatus = 3;

  DateTime selectedDate =   DateTime.now();




  @override
  String getTitle(context, AppState state) {
    if(this.dc.currentPerson.id == null) {
      return '${this.dc.currentDirectory} > Add New Person';
    }
    String personName = this.dc.currentPerson.facebookName;
    return '${this.dc.currentDirectory} > Edit $personName';
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
                title: TextFormField(
                      initialValue: this.dc.currentPerson.facebookName,
                      validator: validateFacebookName,
                      onSaved: (String value) {
                       setState(() { this.dc.currentPerson.facebookName = value;});
                       //   this.dc.currentPerson.facebookName = value;
                       //   print('::::::: $value');
                      },
                      textInputAction: TextInputAction.next,
                  ),
                ),
              Padding( child: Text('Address:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                title: CustomDropDownButton(4),
              ) ,
              Padding( child: Text('Gender:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                  title: CustomDropDownButton(gender),
              ) ,
              Padding( child: Text('Age Group:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                title: CustomDropDownButton(ageGroup),
              ) ,
              Padding( child: Text('Messenger Status:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                title: CustomDropDownButton(messengerStatus),
              ) ,
              Padding( child: Text('Reference Details:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                title: TextFormField(
                  initialValue: this.dc.currentPerson.referenceDetails ,
                  onSaved: (String value) {
                    setState(() { this.dc.currentPerson.referenceDetails = value;});
                   // this.dc.currentPerson.referenceDetails = value;
                    },
                  textInputAction: TextInputAction.next,
                ),
              ) ,
              Padding( child: Text('Assigned To:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                title: TextFormField(
                  initialValue: this.dc.currentPerson.assignedTo ,
                  onSaved: (String value) {
                    setState(() { this.dc.currentPerson.assignedTo = value;});
                    // this.dc.currentPerson.assignedTo = value;
                    },
                  textInputAction: TextInputAction.next,
                ),
              ) ,
              Padding( child: Text('Preached By:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
                title: TextFormField(
                  initialValue: this.dc.currentPerson.preachedBy ,
                  onSaved: (String value) {
                    setState(() { this.dc.currentPerson.preachedBy = value;});
                    //this.dc.currentPerson.preachedBy = value;
                    },
                  textInputAction: TextInputAction.next,
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
                title: TextFormField(
                  initialValue: this.dc.currentPerson.remarks ,
                  onSaved: (String value) {
                    setState(() { this.dc.currentPerson.remarks = value;});
                    //this.dc.currentPerson.remarks = value;
                    },
                  textInputAction: TextInputAction.done,
                ),
              ) ,
              Padding( child: Text('Progress Status:'),
                padding: EdgeInsets.all(5.0),),
              ListTile (
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


  String validateFacebookName(String value) {

    if (value.isEmpty) {
      return 'Facebook name cannot be empty.';}
    //else if( person != null && this.dc.currentPerson.id != person.id) {
    else if( checkForFacebookDuplicate(value) == true ) {
      return 'Duplicate Error. Please change another name.';
    }
    else {
      return null;
    }



      // if (value.isEmpty) {
      //   return 'Facebook name cannot be empty.';}
      // //else if( person != null && this.dc.currentPerson.id != person.id) {
      // else if( this.dc.findPerson(value) != null ) {
      //   return 'Duplicate Error. Please change another name.';
      // }
      // else {
      //   return null;
      // }

  }

  bool checkForFacebookDuplicate(String value) {
    bool result = false;

    this.dc.fbNameList.forEach((element) {
        if (element.toLowerCase() == value.toLowerCase()) {
          result = true;
        }
    });

    return result;

  }



  bool get hideActionButtons {
    if (this.dc.currentPerson.tempImageUploading) {
      return true;
    }
    return false;
  }


  Widget saveButton(BuildContext context) {
    if (this.hideActionButtons) {
      return Container();
    }
    return new Container (
      child: FloatingActionButton.extended (
        heroTag: null,
        onPressed: () {
          if (_formKey.currentState.validate() ) {
            _formKey.currentState.save();
            this.dc.savePerson(this.dc.currentPerson).then((value){
              Navigator.popAndPushNamed(context, '/person_details');
            });
          }
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
    if (this.hideActionButtons) {
      return Container();
    }
    return new Container (
      child: FloatingActionButton.extended (
        heroTag: null,
        onPressed: ()  {
          this.dc.cancelCurrentPersonChanges();
          Navigator.of(context).pop();
          },
        tooltip: 'Cancel',
        icon: Icon(Icons.cancel),
        label: Text("Cancel"),
        shape: RoundedRectangleBorder(borderRadius:
        BorderRadius.all(Radius.circular(20.0))),
      ),
    );
  } //widget ed



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
        print('::::::::: ${this.dc.currentPerson.dateContacted.toString()}');
      });  //setstate
      //   selectedDate = picked;
      //   this.dc.currentPerson.dateContacted = selectedDate.toString();
    }
  }



} // class