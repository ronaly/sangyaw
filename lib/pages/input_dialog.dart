import 'package:flutter/material.dart';

class InputDialog extends StatelessWidget {
  static void show(BuildContext context, {Key key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => InputDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  InputDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Text label = Text('The Label');
    IconButton button = IconButton(
        icon: Icon(Icons.send),
        onPressed: () {
          InputDialog.hide(context);
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
