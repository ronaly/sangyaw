import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_stateful_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/widgets/sangyaw_app_settings.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPage createState() => new _SettingsPage();
}

class _SettingsPage extends AppStatefulLayoutContainer<SettingsPage> {
  @override
  String getTitle() {
    return 'My SangyawApp Settings:';
  }

  Widget buildBody(context, AppState state) {
    return SangyawAppSettings();
  }
}
