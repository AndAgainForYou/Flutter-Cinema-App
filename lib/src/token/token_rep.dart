import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TokenRepository {
  final SharedPreferences _prefs;

  TokenRepository(this._prefs);

  Future<void> saveToken(String token) async {
    await _prefs.setString('accessToken', token);
  }

  Future<String?> getToken() async {
    return _prefs.getString('accessToken');
  }
}

class DataStorage {
  final SharedPreferences _preferences;

  DataStorage(this._preferences);

  List<dynamic> get userData {
    final jsonString = _preferences.getString('userData');
    return jsonString != null ? json.decode(jsonString) : [];
  }

  set userData(List<dynamic> value) {
    final jsonString = json.encode(value);
    _preferences.setString('userData', jsonString);
  }

  List<dynamic> get moviesData {
    final jsonString = _preferences.getString('moviesData');
    return jsonString != null ? json.decode(jsonString) : [];
  }

  set moviesData(List<dynamic> value) {
    final jsonString = json.encode(value);
    _preferences.setString('moviesData', jsonString);
  }

  List<dynamic> get userTicketsData {
    final jsonString = _preferences.getString('userTicketsData');
    return jsonString != null ? json.decode(jsonString) : [];
  }

  set userTicketsData(List<dynamic> value) {
    final jsonString = json.encode(value);
    _preferences.setString('userTicketsData', jsonString);
  }

  List<dynamic> get sessionsData {
    final jsonString = _preferences.getString('sessionsData');
    return jsonString != null ? json.decode(jsonString) : [];
  }

  set sessionsData(List<dynamic> value) {
    final jsonString = json.encode(value);
    _preferences.setString('sessionsData', jsonString);
  }

  Map<String, dynamic> get currentSessionData {
    final jsonString = _preferences.getString('currentSessionData');
    return jsonString != null ? json.decode(jsonString) : {};
  }

  set currentSessionData(Map<String, dynamic> value) {
    final jsonString = json.encode(value);
    _preferences.setString('currentSessionData', jsonString);
  }
}
