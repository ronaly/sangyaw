
import 'package:flutter/material.dart';

import 'app_helpers.dart';

// ignore: must_be_immutable
abstract class AppStatelessWidget extends StatelessWidget with AppHelpers  {
  Widget buildBody(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return buildConnectorBody(context, (context, state) {
      return buildBody(context);
    });
  }

}