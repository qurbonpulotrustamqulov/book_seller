part of 'book_bloc.dart';

abstract class BookState extends Equatable {
    List<Book> allBooks;
   List<BookItem> books;
  int total;
   BookState({required this.books, required this.allBooks, required this.total});
}

class BookInitial extends BookState {
   BookInitial({required super.allBooks, required super.books, required super.total});
  @override
  List<Object> get props => [];
}

class BookLoading extends BookState {
   BookLoading({required super.allBooks, required super.books, required super.total});
  @override
  List<Object> get props => [];
}
class AddTotal extends BookState {
   AddTotal({required super.allBooks, required super.books, required super.total});
  @override
  List<Object> get props => [];
}

class RemoveTotal extends BookState {
   RemoveTotal({required super.allBooks, required super.books, required super.total});
  @override
  List<Object> get props => [];
}
class AddQuantity extends BookState {
   AddQuantity({required super.allBooks, required super.books, required super.total});
  @override
  List<Object> get props => [];
}
class RemoveQuantity extends BookState {
   RemoveQuantity({required super.allBooks, required super.books, required super.total});
  @override
  List<Object> get props => [];
}
class GetAllBooks extends BookState {
   GetAllBooks({required super.allBooks, required super.books, required super.total});
  @override
  List<Object> get props => [];
}

class CheckState extends BookState{
  CheckState({required super.allBooks, required super.books, required super.total});

  @override
  List<Object?> get props => [];
}
