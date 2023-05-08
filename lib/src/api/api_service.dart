import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ApiService {
  static const String baseUrl = 'https://fs-mt.qwerty123.tech/api';

  static Future<Map<String, dynamic>> registrationWithOtp(String phone) async {
    final url = Uri.parse('$baseUrl/auth/otp');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phoneNumber': phone}),
    );

    if (response.statusCode == 200) {
      return ({'success': true});
    } else {
      return {'success': false, 'errorMessage': response.statusCode};
    }
  }

  static Future<Map<String, dynamic>> loginWithOtp(
      String phone, String otp) async {
    final url = Uri.parse('$baseUrl/auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phoneNumber': phone, 'otp': otp}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      final accessToken = responseData['data']['accessToken'] as String;
      return {'success': true, 'accessToken': accessToken};
    } else {
      return {'success': false, 'errorMessage': response.statusCode};
    }
  }

  static Future<Map<String, dynamic>> getUser(String accessToken) async {
    final url = Uri.parse('$baseUrl/user');

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      return {'success': true, 'data': responseData['data']};
    } else {
      return {'success': false, 'errorMessage': response.statusCode};
    }
  }

  static Future<Map<String, dynamic>> updateUserName(
      String accessToken, String name) async {
    final url = Uri.parse('$baseUrl/user');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({'name': name}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      return {'success': true, 'data': responseData['data']};
    } else {
      return {'success': false, 'errorMessage': response.statusCode};
    }
  }

  static Future<Map<String, dynamic>> getMovies(String accessToken) async {
    String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final url = Uri.parse('$baseUrl/movies?date=$date');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      //body: jsonEncode({'name': name}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      return {'success': true, 'data': responseData['data']};
    } else {
      return {'success': false, 'errorMessage': response.statusCode};
    }
  }

  static Future<Map<String, dynamic>> getTickets(String accessToken) async {
    final url = Uri.parse('$baseUrl/user/tickets');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      return {'success': true, 'data': responseData['data']};
    } else {
      return {'success': false, 'errorMessage': response.statusCode};
    }
  }

  static Future<Map<String, dynamic>> getSessions(
      String accessToken, int movieId) async {
    String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final url =
        Uri.parse('$baseUrl/movies/sessions?movieId=$movieId&date=$date');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      return {'success': true, 'data': responseData['data']};
    } else {
      return {'success': false, 'errorMessage': response.statusCode};
    }
  }

  static Future<Map<String, dynamic>> getCurrentSession(
      String accessToken, int sessionId) async {
    final url = Uri.parse('$baseUrl/movies/sessions/$sessionId');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      return {'success': true, 'data': responseData['data']};
    } else {
      return {'success': false, 'errorMessage': response.statusCode};
    }
  }

  static Future<Map<String, dynamic>> bookTicket(
      String accessToken, List<int> seats, int sessionId) async {
    final url = Uri.parse('$baseUrl/movies/book');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'seats': seats,
        'sessionId': sessionId,
      }),
    );

    if (response.statusCode == 200) {
      return {'success': true};
    } else {
      return {'success': false, 'errorMessage': response.statusCode};
    }
  }

  static Future<Map<String, dynamic>> buyTicket(
      String accessToken,
      List<int> seats,
      int sessionId,
      String email,
      String cardNumber,
      String expirationDate,
      String cvv) async {
    final url = Uri.parse('$baseUrl/movies/buy');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'seats': seats,
        'sessionId': sessionId,
        'email': email,
        'cardNumber': cardNumber,
        'expirationDate': expirationDate,
        'cvv': cvv,
      }),
    );

    if (response.statusCode == 200) {
      return {'success': true};
    } else {
      return {'success': false, 'errorMessage': response.statusCode};
    }
  }
}
