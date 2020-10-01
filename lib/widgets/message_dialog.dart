import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:sangyaw_app/widgets/app_stateless_widget.dart';

// ignore: must_be_immutable
class MessageDialog extends AppStatelessWidget {
  String message;
  MessageDialog(this.message);

  static void show(BuildContext context, String message) {
    showDialog<void>(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (_) => MessageDialog(message),
    ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));
  }

  static void hide(BuildContext context) => Navigator.pop(context);

  @override
  Widget buildBody(BuildContext context) {
    Widget body = Scaffold(
      appBar: AppBar(title: RichText(text: TextSpan(text: this.message))),
      bottomNavigationBar: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 12),
          FloatingActionButton.extended(
            heroTag: null,
            onPressed: () => MessageDialog.hide(this.context),
            icon: Icon(Icons.check_circle),
            label: Text('Ok'),
          ),
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: Center(
              child: RichText(
            text: TextSpan(
              text: this.message,
              style: TextStyle(
                fontSize: 20,
                color: Colors.lightBlue,
              ),
            ),
          ))),
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
