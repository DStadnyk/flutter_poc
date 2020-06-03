import 'dart:async';
import 'dart:io';
import 'package:flutterapp/services/provider_service.dart';
import 'package:http/http.dart';

class MockProviderService implements ProviderService {
  @override
  Future<Response> getAsync(String requestUrl) async {
    if (requestUrl ==
        "https://shoppinglist.mcpe.se/api/v1/shoppinglist?customerid=Julianna.Ellesworth@gmail.com") {
      var body = await new File('test/services/shopping_lists_stub.json')
          .readAsString(); 
      return Response(body, HttpStatus.ok);
    }

    return Response('Internal server error', HttpStatus.internalServerError);
  }

  @override
  Future<Response> postAsync(String requestUri, dynamic shoppingList) {
    // TODO: implement postAsync
    throw UnimplementedError();
  }

  @override
  Future<Response> deleteAsync(String requestUri) {
    // TODO: implement deleteAsync
    throw UnimplementedError();
  }
}