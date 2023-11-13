
import 'dart:convert';

import 'package:book_seller/core/apis.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
abstract class Network {
  Future<String?> methodGet({
    required String api,
    String baseUrl = Api.baseUrl,
    Object? id,
    Map<String, String> headers = Api.headers,
    Map<String, String>? query,
  });

  Future<void> methodDelete({
    required String api,
    required Object id,
    String baseUrl = Api.baseUrl,
    Map<String, String> headers = Api.headers,
  });

  Future<void> methodPost({
    required String api,
    required Map<String, Object?> data,
    String baseUrl = Api.baseUrl,
    Map<String, String> headers = Api.headers,
  });

  Future<void> methodPut({
    required String api,
    required Object id,
    required Map<String, Object?> data,
    Map<String, String> headers = Api.headers,
    String baseUrl = Api.baseUrl,
  });

  
}

class HttpNetwork extends Network {
  @override
  Future<String?> methodGet({
    required String api,
    Object? id,
    Map<String, String> headers = Api.headers,
    String baseUrl = Api.baseUrl,
    Map<String, String>? query,
  }) async {
    try{
      final Uri uri = Uri.https(baseUrl, api);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        debugPrint(response.body);

        return utf8.decoder.convert(response.bodyBytes);
      }
      return null;
    }
    catch(e){

      print(e);return null;
    }
  }

  @override
  Future<void> methodPost({
    required String api,
    required Map<String, Object?> data,
    Map<String, String> headers = Api.headers,
    String baseUrl = Api.baseUrl,
  }) async {
    // TODO: implement methodPost
    throw UnimplementedError();
  }

  @override
  Future<void> methodPut({
    required String api,
    required Object id,
    required Map<String, Object?> data,
    Map<String, String> headers = Api.headers,
    String baseUrl = Api.baseUrl,
  }) async {
    // TODO: implement methodPut
    throw UnimplementedError();
  }

  @override
  Future<void> methodDelete({
    required String api,
    required Object id,
    Map<String, String> headers = Api.headers,
    String baseUrl = Api.baseUrl,
  }) {
    // TODO: implement methodDelete
    throw UnimplementedError();
  }

}
