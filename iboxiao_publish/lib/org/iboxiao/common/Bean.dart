class LoginBean {
  bool status;
  Object code;
  Object message;
  LogSuccess data;

  LoginBean({this.status, this.code, this.message, this.data});

  LoginBean.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new LogSuccess.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class LogSuccess {
  String adapterUrl;
  String userId;
  String code;

  LogSuccess({this.adapterUrl, this.userId, this.code});

  LogSuccess.fromJson(Map<String, dynamic> json) {
    adapterUrl = json['adapterUrl'];
    userId = json['userId'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adapterUrl'] = this.adapterUrl;
    data['userId'] = this.userId;
    data['code'] = this.code;
    return data;
  }
}

class Token {
  String scUserId;
  String stPrivateKey;
  String stPublicKey;
  String fullName;
  String st;
  int baseTimestamp;
  String avatar;

  Token(
      {this.scUserId,
      this.stPrivateKey,
      this.stPublicKey,
      this.fullName,
      this.st,
      this.baseTimestamp,
      this.avatar});

  Token.fromJson(Map<String, dynamic> json) {
    scUserId = json['scUserId'];
    stPrivateKey = json['stPrivateKey'];
    stPublicKey = json['stPublicKey'];
    fullName = json['fullName'];
    st = json['st'];
    baseTimestamp = json['baseTimestamp'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scUserId'] = this.scUserId;
    data['stPrivateKey'] = this.stPrivateKey;
    data['stPublicKey'] = this.stPublicKey;
    data['fullName'] = this.fullName;
    data['st'] = this.st;
    data['baseTimestamp'] = this.baseTimestamp;
    data['avatar'] = this.avatar;
    return data;
  }
}
