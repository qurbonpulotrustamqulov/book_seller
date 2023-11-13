
import 'book_model.dart';

class BookItem {
  final String id;
  final Book book;
  int quantity;
  num total;

  BookItem({required this.book, required this.quantity, required this.id})
      : total = book.price * quantity;
}
