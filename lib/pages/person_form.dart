import 'package:flutter/material.dart';
import 'package:sangyaw_app/controller/data_controller.dart';
import 'package:sangyaw_app/model/person.dart';
import 'package:sangyaw_app/utils/ui_utils.dart';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:sangyaw_app/widgets/app_stateless_widget.dart';
import 'package:sangyaw_app/widgets/photo_editor.dart';

import 'loading_dialog.dart';
import 'success_message.dart';

// ignore: must_be_immutable
class PersonForm extends AppStatelessWidget {
  Widget buildBody(context) {
    // START BODY HERE
    Widget body = BlocProvider(
      create: (context) => AllFieldsFormBloc(this.dc),
      child: Builder(
        builder: (context) {
          // ignore: close_sinks
          final formBloc = BlocProvider.of<AllFieldsFormBloc>(context);

          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Scaffold(
              appBar: AppBar(
                  title: Text(this.dc.currentPerson.id == null
                      ? '${this.dc.currentDirectory} > Add Person'
                      : '${this.dc.currentDirectory} > Edit Person')),
              bottomNavigationBar: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FloatingActionButton.extended(
                    heroTag: null,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.cancel),
                    label: Text('Cancel'),
                  ),
                  SizedBox(height: 12),
                  FloatingActionButton.extended(
                    heroTag: null,
                    onPressed: formBloc.submit,
                    icon: Icon(Icons.send),
                    label: Text('SUBMIT'),
                  ),
                ],
              ),
              body: FormBlocListener<AllFieldsFormBloc, String, String>(
                onSubmitting: (context, state) {
                  LoadingDialog.show(context);
                },
                onSuccess: (context, state) {
                  LoadingDialog.hide(context);

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) =>
                          SuccessMessage('Save Success', '/person_details')));
                },
                onFailure: (context, state) {
                  LoadingDialog.hide(context);

                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(state.failureResponse)));
                },
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: <Widget>[
                        PhotoEditor(),
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.facebookNameText,
                          decoration: InputDecoration(
                            labelText: 'Facebook Name',
                            prefixIcon: Icon(Icons.face),
                          ),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.addressText,
                          decoration: InputDecoration(
                            labelText: 'Address (Territory)',
                            prefixIcon: Icon(Icons.terrain),
                          ),
                        ),
                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.genderSelect,
                          decoration: InputDecoration(
                            labelText: 'Gender',
                            prefixIcon: Icon(Icons.wc),
                          ),
                          itemBuilder: (context, value) => value,
                        ),
                        // RadioButtonGroupFieldBlocBuilder<String>(
                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.ageGroupSelect,
                          decoration: InputDecoration(
                            labelText: 'Age Group',
                            prefixIcon: Icon(Icons.group),
                          ),
                          itemBuilder: (context, item) => item,
                        ),
                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.messengerStatusSelect,
                          decoration: InputDecoration(
                            labelText: 'Messenger Status',
                            prefixIcon: Icon(Icons.messenger),
                          ),
                          itemBuilder: (context, item) => item,
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.referenceDetailsText,
                          decoration: InputDecoration(
                            labelText: 'Reference Details',
                            prefixIcon: Icon(Icons.note),
                          ),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.assignedToText,
                          decoration: InputDecoration(
                            labelText: 'Assign To',
                            prefixIcon: Icon(Icons.assignment_ind),
                          ),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.preachedByText,
                          decoration: InputDecoration(
                            labelText: 'Preached By',
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        DateTimeFieldBlocBuilder(
                          dateTimeFieldBloc: formBloc.dateContactedInput,
                          format: DateFormat('MMMM d, yyyy'),
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                          decoration: InputDecoration(
                            labelText: 'Date Contacted',
                            prefixIcon: Icon(Icons.event_note),
                          ),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.remarksText,
                          decoration: InputDecoration(
                            labelText: 'Remarks',
                            prefixIcon: Icon(Icons.description),
                          ),
                        ),
                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.progressStatusSelect,
                          decoration: InputDecoration(
                            labelText: 'Progress Status',
                            prefixIcon: Icon(Icons.assessment),
                          ),
                          itemBuilder: (context, item) => item,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );

    // END/RETURN The body
    return body;
  }
}

const List<String> AGE_GROUP_OPTIONS = [
  '',
  '< 12',
  '12 to 16',
  '17 to 25',
  '26 to 35',
  '36 to 50',
  '> 50'
];
const List<String> GENDER_OPTIONS = ['', 'Male', 'Female'];
const List<String> MESSENGER_STATUS_OPTIONS = ['', 'Active', 'Inactive'];
const List<String> PROGRESS_STATUS_OPTIONS = ['', 'RV', 'BS'];

class AllFieldsFormBloc extends FormBloc<String, String> {
  final facebookNameText = TextFieldBloc();
  final addressText = TextFieldBloc();

  final genderSelect = SelectFieldBloc(
    items: GENDER_OPTIONS,
  );

  final ageGroupSelect = SelectFieldBloc(
    items: AGE_GROUP_OPTIONS,
  );

  // ignore: close_sinks
  final messengerStatusSelect = SelectFieldBloc(
    items: MESSENGER_STATUS_OPTIONS,
  );

  final referenceDetailsText = TextFieldBloc();
  final assignedToText = TextFieldBloc();

  final preachedByText = TextFieldBloc();

  final dateContactedInput = InputFieldBloc<DateTime, Object>();

  final remarksText = TextFieldBloc();

  final progressStatusSelect = SelectFieldBloc(
    items: PROGRESS_STATUS_OPTIONS,
  );

  DataController dc;

  AllFieldsFormBloc(DataController dc) {
    this.dc = dc;

    Person cp = dc.currentPerson;

    facebookNameText.updateValue(cp.facebookName);

    addressText.updateValue(cp.address);
    addressText.updateSuggestions(
        (pattern) => Future.delayed(Duration(seconds: 0)).then((value) {
              return dc.addressList.where((suggest) {
                return suggest.toLowerCase().contains(pattern.toString());
              }).toList();
            }));

    String gender = GENDER_OPTIONS.indexOf(cp.gender) < 0 ? '' : cp.gender;
    genderSelect.updateValue(gender);

    String ageGroup =
        AGE_GROUP_OPTIONS.indexOf(cp.ageGroup) < 0 ? '' : cp.ageGroup;
    ageGroupSelect.updateValue(ageGroup);

    String messengerStatus =
        MESSENGER_STATUS_OPTIONS.indexOf(cp.messengerStatus) < 0
            ? ''
            : cp.messengerStatus;
    messengerStatusSelect.updateValue(messengerStatus);

    referenceDetailsText.updateValue(cp.referenceDetails);

    assignedToText.updateValue(cp.assignedTo);
    assignedToText.updateSuggestions(
        (pattern) => Future.delayed(Duration(seconds: 0)).then((value) {
              return dc.assignToList.where((suggest) {
                return suggest.toLowerCase().contains(pattern.toString());
              }).toList();
            }));

    preachedByText.updateValue(cp.preachedBy);

    dateContactedInput.updateValue(toDate(cp.dateContacted));

    remarksText.updateValue(cp.remarks);

    String progressStatus =
        PROGRESS_STATUS_OPTIONS.indexOf(cp.progressStatus) < 0
            ? ''
            : cp.progressStatus;
    progressStatusSelect.updateValue(progressStatus);

    addFieldBlocs(fieldBlocs: [
      facebookNameText,
      addressText,
      genderSelect,
      messengerStatusSelect,
      ageGroupSelect,
      referenceDetailsText,
      assignedToText,
      preachedByText,
      dateContactedInput,
      remarksText,
      progressStatusSelect,
    ]);
  }

  void cancelChanges() {}

  bool isValid() {
    List<String> names = this.dc.lowerCasedFbNameList;
    String name = facebookNameText.value.toLowerCase();
    if (name == null || name == '') {
      facebookNameText.addFieldError('Facebook Name is required');
      return false;
    }
    if (names.indexOf(name) >= 0) {
      if (this.dc.currentPerson.id == null) {
        // This is for add new
        facebookNameText.addFieldError('Facebook Name already exists');
        return false;
      } else {
        Person p = this.dc.findPerson(name);
        if (p != null && p.id != this.dc.currentPerson.id) {
          facebookNameText.addFieldError(
              'cannot update Facebook Name is used By other record with ID: ${p.id} ');
          return false;
        }
      }
    }

    return true;
  }

  @override
  void onSubmitting() async {
    try {
      print('++++++++++++++++++++++++++++++++++++++++++++++++++');
      print('facebookName: ${facebookNameText.value}');
      print('address: ${addressText.value}');
      print('gender: ${genderSelect.value}');
      print('ageGroup: ${ageGroupSelect.value}');
      print('messengerStatus: ${messengerStatusSelect.value}');
      print('referenceDetails: ${referenceDetailsText.value}');
      print('assignedTo: ${assignedToText.value}');
      print('preachedBy: ${preachedByText.value}');
      print('dateContacted: ${dateContactedInput.value}');
      print('remarks: ${remarksText.value}');
      print('progressStatus: ${progressStatusSelect.value}');
      print('++++++++++++++++++++++++++++++++++++++++++++++++++');
      await Future<void>.delayed(Duration(milliseconds: 500));
      if (this.isValid()) {
        Person cp = this.dc.currentPerson;

        cp.facebookName = facebookNameText.value;
        cp.address = addressText.value;
        cp.gender = genderSelect.value;
        cp.ageGroup = ageGroupSelect.value;
        cp.messengerStatus = messengerStatusSelect.value;
        cp.referenceDetails = referenceDetailsText.value;
        cp.assignedTo = assignedToText.value;
        cp.preachedBy = preachedByText.value;
        cp.dateContacted = dateToString(dateContactedInput.value);
        cp.remarks = remarksText.value;
        cp.progressStatus = progressStatusSelect.value;

        print(cp);

        this.dc.savePerson(this.dc.currentPerson).then((savedPerson) {
          emitSuccess(canSubmitAgain: true);
        });
      } else {
        emitFailure();
      }
    } catch (e) {
      emitFailure();
    }
  }
}
