import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:skillora/helper/globals.dart';
import 'package:skillora/helper/shared_preference_helper.dart';
import 'package:skillora/services/url_endpoints.dart';
import 'package:skillora/utilities/app_constants.dart';

class ApiClient {
  final String baseUrl = UrlEndPoints.baseUrl;
  final String stripeUrl = 'https://api.stripe.com/v1/';

  Future<Map<String, dynamic>> get(String url) async {
    final response = await http.get(
      Uri.parse('$baseUrl$url'),
      headers: _getAuthHeaders(),
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> postImage(
    String updateProfile,
    String path,
  ) async {
    String url = UrlEndPoints.baseUrl + updateProfile;
    Map<String, String> headers = _getAuthHeaders();
    headers['Content-Type'] = 'multipart/form-data';
    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..headers.addAll(headers)
      ..fields.addAll({'user_type': AppConstants.user})
      ..files.add(await http.MultipartFile.fromPath('image', path));
    var response = await request.send();
    var responseData = await http.Response.fromStream(response);
    return _handleResponse(responseData);
  }

  Future<dynamic> post(
    String url, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    final String dataString = json.encode(body);
    url = baseUrl + url;
    logger.d('POST: $url');
    logger.d('Data: $dataString');
    if (headers == null) {
      headers ??= <String, String>{};
      headers.addAll(_getAuthHeaders());
    }

    final response = await http.post(
      Uri.parse(url),
      body: dataString,
      headers: headers,
    );

    return _handleResponse(response);
  }

  Future<dynamic> stripePost(
    String url, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    final String dataString = json.encode(body);
    url = stripeUrl + url;
    logger.d('POST: $url');
    logger.d('Data: $dataString');
    final response = await http.post(
      Uri.parse(url),
      body: body,
      headers: headers,
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> put(
    String url, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    final String dataString = json.encode(body);
    url = baseUrl + url;
    logger.d('PUT: $url');
    logger.d('Data: $dataString');
    headers ??= <String, String>{};
    headers.addAll(_getAuthHeaders());

    final response = await http.put(
      Uri.parse(url),
      body: dataString,
      headers: headers,
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> delete(String url) async {
    final response = await http.delete(
      Uri.parse('$baseUrl$url'),
      headers: _getAuthHeaders(),
    );

    return _handleResponse(response);
  }

  Map<String, String> _getAuthHeaders() {
    String token = SharedPreferenceHelper.getAuthToken();
    logger.d('Authorization token: $token');
    Map<String, String> header = {
      'content-type': 'application/json',
      'Accept': 'application/json',
    };
    if (token.isNotEmpty) {
      header.addAll({
        'Authorization': token,
      });
    }

    return header;
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      logger.d(json.decode(response.body));
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      Map<String, dynamic> body = json.decode(response.body);
      logger.d(body);
      throw body['message'];
    }
  }
}
