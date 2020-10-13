import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:convert';

import '../../commons/app_property.dart';
import '../../commons/app_related_card.dart';

class CollectionBox extends StatefulWidget {
  @override
  _CollectionBoxState createState() => _CollectionBoxState();
}

class _CollectionBoxState extends State<CollectionBox> {
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: StoreStyleProperties.defaultBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(9.0),
                    child: Text(
                      "최근 동영상",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 145,
              child: FutureBuilder(
                future: DefaultAssetBundle.of(context).loadString('assets/api/getSearchList.json'),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('error!');
                  } else {
                    var decodeJson = json.decode(snapshot.data.toString());
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return RelatedVideoWidget(
                          decodeJson[index]['title'],
                          decodeJson[index]['thumbnails'],
                          decodeJson[index]['channelTitle'],
                          decodeJson[index]['duration'],
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Divider(
              color: StoreStyleProperties.dividerColor,
            ),
            Container(
              height: 260,
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    leading: Icon(
                      MaterialCommunityIcons.history,
                      color: Colors.white,
                    ),
                    title: Text(
                      '기록',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      MaterialCommunityIcons.download,
                      color: Colors.white,
                    ),
                    title: Text(
                      '오프라인 저장 동영상',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    subtitle: Text(
                      '동영상 2개',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      MaterialCommunityIcons.play_box_outline,
                      color: Colors.white,
                    ),
                    title: Text(
                      '내 동영상',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      MaterialCommunityIcons.clock,
                      color: Colors.white,
                    ),
                    title: Text(
                      '나중에 볼 동영상',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    subtitle: Text(
                      '시청하지 않은 동영상 26개',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: StoreStyleProperties.dividerColor,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: Text(
                      "재생목록",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                  Container(
                      child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Color.fromRGBO(20, 20, 20, 0.9),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _value,
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              "최근 추가순",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            value: 0,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              "가나다순",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            value: 1,
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                          });
                        },
                      ),
                    ),
                  ))
                ],
              ),
            ),
            Container(
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    leading: Container(
                        width: 40,
                        child: Icon(
                          MaterialCommunityIcons.plus,
                          size: 38,
                          color: Colors.lightBlueAccent,
                        )),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "새 재생목록",
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Container(
                        width: 40,
                        child: ClipRRect(
                          child: Image.asset("assets/images/channel-5.jpg"),
                        )),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Animation Music Collection",
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
                      "동영상 200개",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Container(
                        width: 40,
                        child: ClipRRect(
                          child: Image.asset("assets/images/channel-5.jpg"),
                        )),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Animation Music Collection",
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
                      "동영상 200개",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Container(
                        width: 40,
                        child: ClipRRect(
                          child: Image.asset("assets/images/channel-5.jpg"),
                        )),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Animation Music Collection",
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
                      "동영상 200개",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
