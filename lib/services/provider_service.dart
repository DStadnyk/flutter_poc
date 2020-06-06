import 'dart:convert';
import 'package:http/http.dart' as http;

class ProviderService {
  Future<http.Response> getAsync(String requestUrl) async {
    var response = await http.get(Uri.encodeFull(requestUrl));
    _handleResponse(response);

    return response;
  }

  void _handleResponse(http.Response response) {
    if (response.statusCode != 200) {
      print(response.statusCode);
      throw Exception('Communication with the web server result in an error');
    }
  }

  Future<http.Response> postAsync(String requestUrl, dynamic data) async {
    var body = json.encode(data);
    var response = await http.post(Uri.encodeFull(requestUrl),
        headers: {"Content-Type": "application/json"}, body: body);
    _handleResponse(response);

    return response;
  }

  Future<http.Response> deleteAsync(String requestUrl) async {
    var response = await http.delete(Uri.encodeFull(requestUrl));
    _handleResponse(response);

    return response;
  }
}
