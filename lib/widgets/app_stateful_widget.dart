
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sangyaw_app/controller/data_controller.dart';
import 'package:sangyaw_app/model/app_state.dart';

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