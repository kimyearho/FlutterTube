class Search {
  final dynamic id;
  final String title;
  final String channelTitle;
  final dynamic thumbnails;
  final String duration;
  final String viewCount;
  final String likeCount;
  final String dislikeCount;
  final String publishDate;

  Search({
    this.id,
    this.title,
    this.channelTitle,
    this.thumbnails,
    this.duration,
    this.viewCount,
    this.likeCount,
    this.dislikeCount,
    this.publishDate,
  });

  factory Search.fromJson(Map<String, dynamic> json) {
    return Search(
        id: json['id']['videoId'],
        title: json['snippet']['title'],
        channelTitle: json['snippet']['channelTitle'],
        thumbnails: json['snippet']['thumbnails']['medium']['url'],
        duration: json['duration'],
        viewCount: json['viewCount'],
        likeCount: json['likeCount'],
        dislikeCount: json['dislikeCount'],
        publishDate: json['snippet']['publishedAt']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> searchModel = new Map<String, dynamic>();
    searchModel['id'] = this.id;
    searchModel['title'] = this.title;
    searchModel['channelTitle'] = this.channelTitle;
    searchModel['thumbnails'] = this.thumbnails;
    searchModel['duration'] = this.duration;
    searchModel['viewCount'] = this.viewCount;
    searchModel['likeCount'] = this.likeCount;
    searchModel['dislikeCount'] = this.dislikeCount;
    searchModel['publishDate'] = this.publishDate;
    return searchModel;
  }
}
