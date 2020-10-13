import 'package:flutter/material.dart';

import '../commons/app_property.dart';
import '../widgets/detail/video_detail.dart';

class VideoCard extends StatefulWidget {
  final String id;
  final String title;
  final String channelTitle;
  final String thumbnails;
  final String duration;
  final String viewCount;
  final String likeCount;
  final String dislikeCount;
  final String publishDate;

  VideoCard(
    this.id,
    this.title,
    this.channelTitle,
    this.thumbnails,
    this.duration,
    this.viewCount,
    this.likeCount,
    this.dislikeCount,
    this.publishDate,
  );

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: StoreStyleProperties.videoCardColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.network(
                widget.thumbnails,
                width: 400,
                height: 215,
                fit: BoxFit.fitWidth,
              ),
              Positioned(
                  right: 5.0,
                  bottom: 5.0,
                  child: Container(
                    child: Text(
                      widget.duration,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    decoration: BoxDecoration(color: Colors.black),
                    padding: EdgeInsets.all(5.0),
                  ))
            ],
          ),
          ListTile(
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
            subtitle: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.channelTitle + '  /  ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      widget.viewCount + ' 회',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoDetail(
                    widget.id,
                    widget.title,
                    widget.channelTitle,
                    widget.viewCount,
                    widget.likeCount,
                    widget.dislikeCount,
                    widget.publishDate,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
