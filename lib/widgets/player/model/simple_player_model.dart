import 'package:flutter/material.dart';
import 'dart:math';

// 재생한 비디오가 있을경우 상세 페이지를 제외한 다른 페이지에서 작은 플레이어를 하단에 표시한다.
class SimplePlayerControlModel with ChangeNotifier {
  String _thumbnail;
  String _videoTitle;
  String _subTitle;
  String _videoId;
  String get videoId => _videoId;

  SimplePlayerControlModel(
      this._thumbnail, this._videoTitle, this._subTitle, this._videoId);

  SimplePlayerControlModel.empty() {
    this._thumbnail = '';
    this._videoTitle = '';
    this._subTitle = '';
    this._videoId = '';
  }

  void setVideoId(String videoId) {
    _videoId = videoId;
    notifyListeners();
  }

  void updateVideoIdModel() {
    setVideoId(randomNumber());
  }

  String randomNumber() {
    Random random = new Random();
    int randomNumber = random.nextInt(10000);
    return randomNumber.toString();
  }

  Map<String, dynamic> getData() {
    Map<String, dynamic> videoModel = new Map<String, dynamic>();
    videoModel['videoId'] = this._videoId;
    videoModel['videoTitle'] = this._videoTitle;
    videoModel['subTitle'] = this._subTitle;
    videoModel['thumbnail'] = this._thumbnail;
    return videoModel;
  }
}
