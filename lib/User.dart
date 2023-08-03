class User{
  String? userId;
  String? instagramId;
  String? facebookId;
  String? redditId;
  String? quoraId;
  String? twitterId;

  User({ this.userId,  this.instagramId,  this.facebookId,  this.redditId,  this.quoraId, this.twitterId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      instagramId: json['instagramId'],
      facebookId: json['facebookId'],
      redditId: json['redditId'],
      quoraId: json['quoraId'],
      twitterId: json['twitterId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['instagramId'] = instagramId;
    data['facebookId'] = facebookId;
    data['redditId'] = redditId;
    data['quoraId'] = quoraId;
    data['twitterId'] = twitterId;
    return data;
  }

  }