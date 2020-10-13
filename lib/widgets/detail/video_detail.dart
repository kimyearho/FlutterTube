import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'dart:convert';
import 'model/related_model.dart';
import '../../commons/app_property.dart';
import '../../commons/app_endpoint.dart';
import '../../commons/custom_card.dart';
import '../../commons/app_dialog.dart';

class VideoDetail extends StatefulWidget {
  final String id;
  final String title;
  final String channelTitle;
  final String viewCount;
  final String likeCount;
  final String dislikeCount;
  final String publishDate;

  VideoDetail(
    this.id,
    this.title,
    this.channelTitle,
    this.viewCount,
    this.likeCount,
    this.dislikeCount,
    this.publishDate,
  );

  @override
  _VideoDetailState createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {
  YoutubePlayerController _controller;
  Future<List<RelatedVideo>> props;

  @override
  void initState() {
    super.initState();
    // YT Video Controller Init
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
      ),
    );
    // 연관 비디오 조회
    props = this._getRelatedVideos();
  }

  // 연관 비디오 검색
  _getRelatedVideos() {
    return AppEndPoint.getVideoList(widget.id).then((response) {
      var data = json.decode(response.body);
      var searchData = data['items'];
      Future<dynamic> _futureMergeData = AppEndPoint.getVideosDuration(searchData);
      return _futureMergeData.then((data) {
        Iterable inter = data;
        List<RelatedVideo> list = inter.map((model) => RelatedVideo.fromJson(model)).toList();
        return list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String _videoTitle = widget.title;
    String _channelTitle = widget.channelTitle;

    return Scaffold(
      backgroundColor: StoreStyleProperties.defaultBackgroundColor,
      body: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 24.0),
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.amber,
                progressColors: ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent,
                ),
                onReady: () {
                  print('Player is ready.');
                },
              )),
          ListTile(
            title: Text(
              _videoTitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Text(
                  '조회수 ' + widget.viewCount + ' 회' + ' / ' + widget.publishDate,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              InkWell(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.thumb_up,
                      color: Colors.blue,
                      size: 22.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0),
                    ),
                    Text(
                      widget.likeCount,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                onTap: () => AppDialog.showDefaultDialog(context, 'Sample1 !'),
              ),
              InkWell(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.thumb_down,
                      color: Colors.pink,
                      size: 22.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0),
                    ),
                    Text(
                      widget.dislikeCount,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                onTap: () => AppDialog.showDefaultDialog(context, 'Sample2 !'),
              ),
              InkWell(
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.share,
                        color: Colors.amberAccent,
                        size: 22.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                      ),
                      Text(
                        '공유',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  //+Feature 클릭시 기본 팝업 표시
                  onTap: () => AppDialog.showDefaultDialog(context, 'Not Feature Share!')),
              Column(
                children: <Widget>[
                  Icon(
                    Icons.save,
                    color: Colors.deepPurple,
                    size: 22.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                  ),
                  Text(
                    '저장',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
          Divider(),
          Divider(
            color: StoreStyleProperties.dividerColor,
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 20),
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/channel-5.jpg'),
              //backgroundColor: Colors.black,
            ),
            title: Text(
              _channelTitle,
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: FlatButton(
              child: Text(
                '구독',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              onPressed: null,
            ),
          ),
          Divider(
            color: StoreStyleProperties.dividerColor,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Text(
                  "다음 동영상",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: props,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Expanded(
                  child: ListView.builder(
                    addAutomaticKeepAlives: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CustomRelatedList(
                        thumbnail: snapshot.data[index].thumbnails,
                        title: snapshot.data[index].title,
                        author: snapshot.data[index].channelTitle,
                        viewCount: snapshot.data[index].viewCount,
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  } // build
}
