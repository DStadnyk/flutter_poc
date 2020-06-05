import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutterapp/services/provider_service.dart';
import 'package:http/http.dart';

class MockProviderService implements ProviderService {
  @override
  Future<Response> getAsync(String requestUrl) async {
    if (requestUrl !=
        "https://shoppinglist.mcpe.se/api/v1/shoppinglist?customerid=Julianna.Ellesworth@gmail.com") {
      return _errorResponse();
    }

    var body =
        await new File('test/stubs/shopping_lists_stub.json').readAsString();

    return Response(body, HttpStatus.ok);
  }

  @override
  Future<Response> postAsync(String requestUrl, dynamic data) async {
    if (requestUrl != "https://shoppinglist.mcpe.se/api/v1/shoppinglist" &&
        data == null) {
      return _errorResponse();
    }
    return Response(json.encode(data), HttpStatus.ok);
  }

  @override
  Future<Response> deleteAsync(String requestUrl) async {
    if (requestUrl != "https://shoppinglist.mcpe.se/api/v1/shoppinglist/186") {
      return _errorResponse();
    }

    return Response('Success', HttpStatus.ok);
  }

  Response _errorResponse() {
    return Response('Internal server error', HttpStatus.internalServerError);
  }
}
