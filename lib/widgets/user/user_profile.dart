import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../player/model/simple_player_model.dart';
import 'package:flutter_tube/widgets/player/simple_player.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final myModel = Provider.of<SimplePlayerControlModel>(context);
    return Scaffold(
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: RaisedButton(
                        color: Colors.blue,
                        onPressed: () => myModel.updateVideoIdModel(),
                        child: Text(
                          'Random VideoID 추가',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: RaisedButton(
                        color: Colors.redAccent,
                        onPressed: () => myModel.setVideoId(""),
                        child: Text(
                          'VideoID 삭제',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 50,
                    child: SimplePlayerWidget(), // 재생중인 비디오가 있으면 하단에 표시한다.
                  ),
                )
              ]),
        ));
  }
}