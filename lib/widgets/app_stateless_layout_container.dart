
import 'package:flutter/material.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/widgets/app_helpers.dart';

// ignore: must_be_immutable
abstract class AppStatelessLayoutContainer extends StatelessWidget with AppHelpers {
String getTitle();
  Widget buildBody(context, AppState state);

  @override
  Widget build(BuildContext context) {    
    return buildConnectorBody(context, (context, state) {
      return sangyawAppScafold(context, this.buildBody(context, state), this.getTitle());
    });
  }

}
