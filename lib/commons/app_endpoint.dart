import 'app_property.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../commons/utils.dart';

class AppEndPoint {
  /* 검색 목록을 조회 */
  static Future<dynamic> getSearchVideos() {
    Map<String, String> queryParams = {
      'part': "snippet",
      'fields': StoreProperties.fields,
      'q': StoreProperties.q,
      'type': StoreProperties.type,
      'maxResults': '10',
      'key': StoreProperties.key
    };

    var searchDomain = StoreProperties.domain + '/search';
    Uri uri = Uri.parse(searchDomain);
    uri = uri.replace(queryParameters: queryParams);
    print(uri);

    return http.get(uri);
  }

  /* 키워드 연관 비디오 목록 조회 */
  static Future getVideoList(videoId) {
    Map<String, String> queryParams = {
      'part': "snippet",
      'fields': StoreProperties.fields,
      'relatedToVideoId': videoId,
      'type': 'video',
      'maxResults': '10',
      'key': StoreProperties.key
    };

    var searchDomain = StoreProperties.domain + '/search';
    Uri uri = Uri.parse(searchDomain);
    uri = uri.replace(queryParameters: queryParams);
    print(uri);

    return http.get(uri);
  }

  /* 비디오 재생시간 및 통계 조회 */
  static Future getVideosDuration(data) async {
    var _searchData = data;
    var videoIdList = _searchData
        .map((dynamic data) {
          return data['id']['videoId'];
        })
        .toList()
        .join(',');

    Map<String, dynamic> queryParams = {
      'part': "contentDetails,statistics",
      'fields': StoreProperties.getVideoField,
      'id': videoIdList,
      'key': StoreProperties.key
    };

    var videoDomain = StoreProperties.domain + '/videos';
    Uri uri = Uri.parse(videoDomain);
    uri = uri.replace(queryParameters: queryParams);

    var response = await http.get(uri);
    var videoDomainData = json.decode(response.body);
    var videoDomainItems = videoDomainData['items'];

    var videoList = [];
    for (int i = 0; i < _searchData.length; i++) {
      String videoId = _searchData[i]['id']['videoId'];
      for (int j = 0; j < videoDomainItems.length; j++) {
        if (videoId == videoDomainItems[j]['id']) {
          String isoDuration = videoDomainItems[j]['contentDetails']['duration'];
          _searchData[i]['viewCount'] = videoDomainItems[j]['statistics']['viewCount'];
          _searchData[i]['likeCount'] = videoDomainItems[j]['statistics']['likeCount'];
          _searchData[i]['dislikeCount'] = videoDomainItems[j]['statistics']['dislikeCount'];
          _searchData[i]['duration'] = Utils.getDuration(isoDuration);
        }
      } // end for 2
      videoList.add(_searchData[i]);
    } // end for 1
    return Future.delayed(Duration(seconds: 1), () => videoList);
  }
}
