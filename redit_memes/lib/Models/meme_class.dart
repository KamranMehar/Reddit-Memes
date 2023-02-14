class Meme {
  String? title;
  String? link;
  bool? isSafe;
  String? subredditName;
  double? upVotes;
  double? downVotes;

  Meme(
      {this.title,
        this.link,
        this.isSafe,
        this.subredditName,
        this.upVotes,
        this.downVotes});

  Meme.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
    isSafe = json['is_safe'];
    subredditName = json['subreddit_name'];
    upVotes = json['up_votes'];
    downVotes = json['down_votes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['link'] = this.link;
    data['is_safe'] = this.isSafe;
    data['subreddit_name'] = this.subredditName;
    data['up_votes'] = this.upVotes;
    data['down_votes'] = this.downVotes;
    return data;
  }
}
