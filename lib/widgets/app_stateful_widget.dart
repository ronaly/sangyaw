
import 'package:flutter/material.dart';

import 'app_helpers.dart';

abstract class AppStatefulWidget<T extends StatefulWidget> extends State<T> with AppHelpers  {
  Widget buildBody(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return buildConnectorBody(context, (context, state) {
      return buildBody(context);
    });
  }

}