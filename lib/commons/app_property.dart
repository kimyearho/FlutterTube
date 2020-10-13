import 'package:flutter/material.dart';

class StoreProperties {
  static const domain = 'https://www.googleapis.com/youtube/v3';
  static const part = 'snippet';
  static const fields = 'items(id(videoId), snippet(title, publishedAt, channelTitle, thumbnails(medium)))';
  static const q = 'Demon Slayer OST';
  static const type = 'video';
  static const key = 'AIzaSyAQpIjdUyfVYWkH4NItTS_1cyn9s8w2Ixc';
  static const getVideoField = 'items(id,contentDetails(duration),statistics(viewCount, likeCount, dislikeCount))';
}

class StoreStyleProperties {
  static const defaultBackgroundColor = Color.fromRGBO(20, 20, 20, 0.9);
  static const videoCardColor =  Color.fromRGBO(32, 32, 32, 1.0);
  static const borderColor = Color.fromRGBO(136, 136, 136, 0.5);
  static const dividerColor = Color.fromRGBO(136, 136, 136, 0.8);
  static const systemBarColor = Color.fromRGBO(32, 32, 32, 1.0);
}
