import 'package:flutter/material.dart';

import 'app_stateful_widget.dart';

typedef InputDialogCallback = void Function(String input);

// ignore: must_be_immutable
class InputDialog extends StatefulWidget {
  InputDialogCallback callback;
  InputDialog(this.callback);
  @override
  _InputDialog createState() => _InputDialog(this.callback);

  static void show(BuildContext context, InputDialogCallback callback) =>
      showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => InputDialog(callback),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);
}

class _InputDialog extends AppStatefulWidget<InputDialog> {
  InputDialogCallback callback;
  _InputDialog(this.callback);
  @override
  Widget buildBody(BuildContext context) {
    Text label = Text('The Label');
    IconButton button = IconButton(
        icon: Icon(Icons.send),
        onPressed: () {
          InputDialog.hide(context);
          this.callback('TheValueReturned');
        });
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Row(
            children: [label, button],
          ),
        ),
      ),
    );
  }
}
