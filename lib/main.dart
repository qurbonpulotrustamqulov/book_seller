import 'package:book_seller/app.dart';
import 'package:book_seller/services/network_service.dart';
import 'package:book_seller/domain/repositories/book_repository.dart';
import 'package:flutter/cupertino.dart';
BookRepository repository = BookRepositoryImplementation(network: HttpNetwork());
void main(){

  runApp(const App());
}