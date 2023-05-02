class User {
  String? _sId;
  String? email;
  String? userId;
  String? userName;
  int?  _iV;
  User({this.email, this.userId, this.userName});

  User.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    email = json['email'];
    userId = json['userId'];
    userName = json['userName'];
    _iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = _sId;
    data['email'] = email;
    data['userId'] = userId;
    data['userName'] = userName;
    data['__v'] = _iV;
    return data;
  }
}
