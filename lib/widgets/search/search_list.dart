import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import '../../commons/app_endpoint.dart';
import '../../commons/app_video_card.dart';
import '../player/simple_player.dart';
import '../../commons/utils.dart';
import 'model/search_model.dart';

import 'package:provider/provider.dart';
import '../player/model/simple_player_model.dart';

class SearchList extends StatefulWidget {
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  // Future<List<Search>> getSearchList;

  @override
  void initState() {
    super.initState();
    // 클래스 초기화시 검색조회 실행
    // getSearchList = this._getSearch();
  }

  @override
  Widget build(BuildContext context) {
    final myModel = Provider.of<SimplePlayerControlModel>(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(20, 20, 20, 0.9),
      body: Column(
        children: <Widget>[
          FutureBuilder(
            // LocalJsonFile 을 읽어들인다.
            // 검색시 YT 할당량을 대량으로 소비하므로 검색 API 를 최대한 자제해야한다.
            future: DefaultAssetBundle.of(context).loadString('assets/api/getSearchList.json'),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                var decodeJson = json.decode(snapshot.data.toString());
                return Expanded(
                  child: ListView.builder(
                    addAutomaticKeepAlives: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    itemCount: decodeJson.length,
                    itemBuilder: (BuildContext context, int index) {
                      return VideoCard(
                          decodeJson[index]['id'],
                          Utils.replaceTitle(decodeJson[index]['title']),
                          decodeJson[index]['channelTitle'],
                          decodeJson[index]['thumbnails'],
                          decodeJson[index]['duration'],
                          Utils.numberGrouping(decodeJson[index]['viewCount']),
                          Utils.numberGrouping(decodeJson[index]['likeCount']),
                          Utils.numberGrouping(decodeJson[index]['dislikeCount']),
                          decodeJson[index]['publishDate']);
                    },
                  ),
                );
              } // else
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: myModel.videoId != "" ? 50 : 0,
              child: SimplePlayerWidget(), // 재생중인 비디오가 있으면 하단에 표시한다.
            ),
          )
        ],
      ),
    );
  } // widget build

  _getSearch() {
    return AppEndPoint.getSearchVideos().then((response) {
      var data = json.decode(response.body);
      var searchData = data['items'];
      Future<dynamic> _futureMergeData = AppEndPoint.getVideosDuration(searchData);
      return _futureMergeData.then((data) {
        Iterable inter = data;
        List<Search> list = inter.map((model) => Search.fromJson(model)).toList();
        return list;
      });
    });
  }
}
