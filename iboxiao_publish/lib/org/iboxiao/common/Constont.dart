class IBXURL {
  /// 登录地址
  static const String LOGIN_URL =
      'http://user.iboxiao.com:18080/ibc-user/anonymous/user/bxlogin';

  /// 获取信息发布地址url
  static const String GET_ADDRESS =
      "/bxn-core-platform/api/public/base-platform/locate-service?appKey=BXI-PUBLISH";

  static const String GET_TOKEN = "/api/p1/login/getToken";
}

class SharedPreferenceKey {
  static const String USER_ID_KEY = "userid";
  static final String COOKIE = "cookie"; // cookie
  static const String LOGIN_STATUS = "login_status"; // cookie
  static final String ADDRESS = "address";
  static const String TOKEN = "token";
  static final String SERIALIZABLE_USER = "/token.dat";
}
