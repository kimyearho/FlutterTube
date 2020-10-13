import 'package:flutter/material.dart';
import '../commons/app_property.dart';

class TopAppBar extends StatefulWidget with PreferredSizeWidget {
  @override
  _AppBarState createState() => _AppBarState();

  @override
  Size get preferredSize => Size.fromHeight(55.0);
}

class _AppBarState extends State<TopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // 제목 간격을 0으로
      titleSpacing: 15,
      title: Image.asset('assets/images/youtube-music.png', width: 120, fit: BoxFit.cover),
      backgroundColor: StoreStyleProperties.systemBarColor,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.videocam,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        Container(
          width: 55,
          height: 50,
          padding: EdgeInsets.all(12.0),
          child: CircleAvatar(
            radius: 5.0,
            backgroundImage: AssetImage('assets/images/17153380.png'),
          ),
        )
      ],
    );
  }
}
