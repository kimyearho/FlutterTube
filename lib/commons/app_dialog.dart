import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../commons/app_property.dart';

class AppDialog {
  static void showDefaultDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Demo"),
          content: Text(text),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  static void settingModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: StoreStyleProperties.videoCardColor,
      isDismissible: false,
      builder: (BuildContext bc) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: Icon(
                    MaterialCommunityIcons.eye_off_outline,
                    color: Colors.white,
                  ),
                  title: Text(
                    '이 알림 숨기기',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () => {}),
              ListTile(
                leading: Icon(
                  MaterialCommunityIcons.bell_off_outline,
                  color: Colors.white,
                ),
                title: Text(
                  '이 채널의 모든 알림 끄기',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () => {},
              ),
              Divider(
                color: StoreStyleProperties.dividerColor,
              ),
              ListTile(
                leading: Icon(
                  Icons.clear_sharp,
                  color: Colors.white,
                ),
                title: Text(
                  '취소',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
