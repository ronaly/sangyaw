import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';

class ClearImageCache extends AppStatelessLayoutContainer {
  @override
  String getTitle(context, AppState state) {
    return 'Clear Image Cache';
  }


  Widget buildBody(context, AppState state) {

    // START BODY HERE
    Widget body  = Wrap(
        children: <Widget> [
          RichText(
            text: TextSpan(
              text: 'Are you sure you want to remove all local cached images? this will reload all images from Sangyaw App Server \n (e delete niya ang mga image nga imu makita sa Sangyaw App, ug mo download balik sa Sangyaw App Server)',
              style: TextStyle(
                fontSize: 20,
                color: Colors.lightBlue,
              ),
            ),
          ),
          this.getButtons(context),
        ]
    );

    // END/RETURN The body
    return Center(
      child: body,
    );

  }



  Widget buttonWidget(Icon icon, String caption, VoidCallback callback) {
    return Column(children: [
      IconButton(
        color: Colors.blueAccent,
        iconSize: 100.0,
        onPressed: callback,
        icon: icon,
        tooltip: caption,
      ),
      Text(caption),
    ]);
  }

  Widget getButtons(context) {
    return Row(
        children: <Widget> [
          this.buttonWidget(Icon(Icons.cancel), 'Cancel', (){
            Navigator.pop(context);
          }),
          this.buttonWidget(Icon(Icons.delete), 'Clear Image Cache', (){
            DefaultCacheManager().emptyCache();
            Navigator.pop(context);
          }),
        ]
    );

  }

}
