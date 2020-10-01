import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sangyaw_app/controller/data_controller.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/pages/settings_page.dart';
import 'package:sangyaw_app/utils/spinner.dart';

import 'bottom_menu.dart';
import 'directory_list.dart';
import 'drawer_menu.dart';
import 'sangyaw_app_settings.dart';

typedef BuildConnectorBodyFunc = Widget Function(
    BuildContext context, AppState state);

mixin AppHelpers {
  Container decoratedContainer(Widget child) {
    Container cont = Container(
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: Colors.black,
        //   width: 5,
        // ),
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          new BoxShadow(
            color: Colors.lightBlue[50],
            offset: new Offset(1.0, 1.0),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10.0),
      alignment: Alignment.center,
      child: Card(child: child),
    );
    return cont;
  }

  Widget expandableContainer(Widget header, Widget contents, Widget footer) {
    List<Widget> arr = [];
    if (header != null) {
      Widget head = Column(
        children: [header],
      );

      arr.add(head);
    }

    if (contents != null) {
      SingleChildScrollView inner = SingleChildScrollView(
        padding: EdgeInsets.zero,
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [contents],
          ),
        ),
      );
      Expanded expandable = Expanded(child: inner);
      arr.add(expandable);
    }

    if (header != null) {
      Widget foot = Column(
        children: [footer],
      );

      arr.add(foot);
    }

    return SafeArea(
      child: Column(
        children: arr,
      ),
    );
  }

  DataController dataController;
  DataController getDataController() {
    return this.dataController;
  }

  BuildContext context;
  AppState state;
  Store<AppState> store;

  DataController get dc => this.getDataController();
  String congregationName = '- Unknown -';

  final _loadingTitle = 'Loading please wait ...';

  Widget buildConnectorBody(BuildContext context, BuildConnectorBodyFunc func) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          this.context = context;
          this.state = state;
          this.store = StoreProvider.of<AppState>(context);
          this.dataController = new DataController(this.store);
          this.congregationName = this
              .dc
              .congregationList[this.dc.globals.congregation]
              ?.folderName;
          return func(context, state);
        });
  }

  Widget sangyawAppScafold(BuildContext context, Widget body, String title) {
    return buildConnectorBody(context, (context, state) {
      Widget renderMe;
      String strTitle;

      if (this.dc.error) {
        strTitle = this.dc.errorTitle;
        renderMe = Text(this.dc.errorMessage);
      } else if (this.dc.loading) {
        strTitle = _loadingTitle;
        return getAppSpinner();
      } else if (this.dc.globals.congregation == null ||
          this is TheSettingsPage) {
        strTitle = 'Please Select your Congreation!';
        renderMe = SangyawAppSettings();
      } else if (this.dc.currentDirectory == null) {
        renderMe = Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: DirectoryList());
        strTitle = 'Please select a Directory';
      } else {
        renderMe = body;
        strTitle = '${this.dc.currentDirectory} > $title';
      }
      return Scaffold(
        appBar: AppBar(
          title: RichText(
            text: TextSpan(
              text: strTitle,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        drawer: DrawerMenu(),
        bottomNavigationBar: BottomMenu(),
        body: Container(margin: EdgeInsets.all(10.0), child: renderMe),
      );
    });
  }
}
