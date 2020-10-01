import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import 'app_stateful_widget.dart';

typedef InputDialogCallback = void Function(String input);

// ignore: must_be_immutable
class InputDialog extends StatefulWidget {
  InputDialogCallback callback;
  String message;
  String fieldName;
  InputDialog(this.callback, this.fieldName, this.message);
  @override
  _InputDialog createState() =>
      _InputDialog(this.callback, this.fieldName, this.message);

  static void show(BuildContext context, InputDialogCallback callback,
      [String fieldName = 'Input Text',
      String message = 'Please Enter Your Input Text']) {
    showDialog<void>(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (_) => InputDialog(callback, fieldName, message),
    ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));
  }

  static void hide(BuildContext context) => Navigator.pop(context);
}

class _InputDialog extends AppStatefulWidget<InputDialog> {
  InputDialogCallback callback;
  String message;
  String fieldName;
  _InputDialog(this.callback, this.fieldName, this.message);

  @override
  Widget buildBody(BuildContext context) {
    Widget body = BlocProvider(
      create: (context) => InputFormBlock(this.fieldName),
      child: Builder(
        builder: (context) {
          // ignore: close_sinks
          final formBloc = BlocProvider.of<InputFormBlock>(context);

          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Scaffold(
              appBar: AppBar(title: Text(this.message)),
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
                    icon: Icon(Icons.check_circle),
                    label: Text('Ok'),
                  ),
                ],
              ),
              body: FormBlocListener<InputFormBlock, String, String>(
                onSubmitting: (context, state) {},
                onSuccess: (context, state) {
                  InputDialog.hide(context);
                  this.callback(formBloc.inputText.value);
                },
                onFailure: (context, state) {
                  InputDialog.hide(context);
                },
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: <Widget>[
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.inputText,
                          decoration: InputDecoration(
                            labelText: 'please enter ${this.fieldName}',
                            prefixIcon: Icon(Icons.input),
                          ),
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
    return body;
  }
}

class InputFormBlock extends FormBloc<String, String> {
  String fieldName;
  final inputText = TextFieldBloc();

  InputFormBlock(this.fieldName) {
    inputText.updateValue('');

    addFieldBlocs(fieldBlocs: [
      inputText,
    ]);
  }

  void cancelChanges() {}

  bool isValid() {
    String name = inputText.value.toLowerCase();
    if (name == null || name == '') {
      inputText.addFieldError('${this.fieldName} is required');
      return false;
    }
    return true;
  }

  @override
  void onSubmitting() async {
    try {
      if (this.isValid()) {
        emitSuccess(successResponse: inputText.value);
      } else {
        // emitFailure();
      }
    } catch (e) {
      emitFailure();
    }
  }
}
