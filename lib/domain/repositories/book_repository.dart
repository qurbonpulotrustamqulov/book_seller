import 'dart:convert';

import 'package:book_seller/core/apis.dart';
import 'package:book_seller/data/models/book_model.dart';
import 'package:book_seller/services/network_service.dart';


abstract class BookRepository {
  Future<List<Book>> fetchBook();
}

class BookRepositoryImplementation extends BookRepository {
  final Network network;

  BookRepositoryImplementation({required this.network});

  @override
  Future<List<Book>> fetchBook() async {

    String response =
        await network.methodGet(api: Api.apiSearch) ??
            '[]';
    final json = jsonDecode(response) as List; /// String => json(Map, List, ...)
    return json.map((item) => Book.fromJson(item)).toList();

  }

}