import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../commons/app_dialog.dart';

class AppAlarmCard extends StatefulWidget {
  final String id;
  final String title;
  final String publishDate;
  final String thumbnails;

  AppAlarmCard(this.id, this.title, this.publishDate, this.thumbnails);

  @override
  _AppAlarmState createState() => _AppAlarmState();
}

class _AppAlarmState extends State<AppAlarmCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: ListTile(
            leading: Container(
              width: 40,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/channel-5.jpg'),
              ),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            subtitle: Text(
              widget.publishDate,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.thumbnails),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: InkWell(
            child: Icon(
              MaterialIcons.more_vert,
              color: Colors.white,
            ),
            onTap: () => AppDialog.settingModalBottomSheet(context),
          ),
        )
      ],
    );
  }
}
