import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String accessTokenKey = "accessToken";
  static final String refreshTokenKey = 'refreshToken';
  static final String mUserId = "userId";
  static final String isUserVerified = "verified";
  static final String isSignUp = "isSignUp";

  static Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString(accessTokenKey);
    return accessToken != null;
  }

  static Future<bool> isVerified() async {
    bool isVerified = false;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isVerified = prefs.getBool(isUserVerified);
    return isVerified;
  }

  static Future<bool> isUserSignUp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var isUserSignUp = prefs.getBool(isSignUp);
    return isUserSignUp == null ? false : isUserSignUp;
  }

  static Future<String> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(accessTokenKey) ?? null;
  }

  static Future<String> getRefreshToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(refreshTokenKey) ?? null;
  }

  static Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(mUserId) ?? null;
  }

  static Future setUserId(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(mUserId, userId);
  }

  static Future<bool> clearPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
