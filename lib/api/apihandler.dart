import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiProvider {
  String url = 'url for API';
  postData(data, apiUrl) {
    String fullUrl = url + apiUrl;
    return http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}
