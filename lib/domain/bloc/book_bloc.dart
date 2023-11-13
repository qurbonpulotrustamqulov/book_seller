
import 'package:bloc/bloc.dart';
import 'package:book_seller/data/models/book_model.dart';
import 'package:book_seller/data/models/item_model.dart';
import 'package:book_seller/main.dart';
import 'package:equatable/equatable.dart';
part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super( BookInitial(allBooks: const [], books: const [],total: 0)) {
    on<AddQuantityEvent>(_addQuantity);
    on<RemoveQuantityEvent>(_removeQuantity);
    on<GetAllBookEvent>(_getAllBooks);
    on<AddTotalEvent>(_addTotal);
    on<CheckEvent>(_checkBloc);
  }
  void _addQuantity(AddQuantityEvent event, Emitter emitter){
    final books = state.books;
    final allBooks = state.allBooks;
    final total = state.total;
    emit(BookLoading(allBooks: allBooks, books: books,total: total));
    if(books.contains(event.bookItem)){
      books[books.indexOf(event.bookItem)].quantity++;
    }
    emit(AddQuantity(allBooks: allBooks, books: books, total: total));
  }
  void _removeQuantity(RemoveQuantityEvent event, Emitter emitter){
    final books = state.books;
    final allBooks = state.allBooks;
    final total = state.total;
    emit(BookLoading(allBooks: allBooks, books: books,total: total));
    if(books.contains(event.bookItem)){
      books[books.indexOf(event.bookItem)].quantity--;
    }
    emit(AddQuantity(allBooks: allBooks, books: books, total: total));
  }

  void _addTotal(AddTotalEvent event, Emitter emitter){
    final books = state.books;
    final allBooks = state.allBooks;
    final total = state.total;
    emit(BookLoading(allBooks: allBooks, books: books,total: total));

    emit(AddTotal(allBooks: allBooks, books: books, total: event.sum * event.bookItem.quantity));
  }

  void _getAllBooks(GetAllBookEvent event, Emitter emitter) async {
    emit(BookLoading(allBooks: state.allBooks, books: state.books,total: state.total));
    state.allBooks = await repository.fetchBook();
    state.books =
        state.allBooks.map((e) => BookItem(book: e, quantity: 0, id: e.id)).toList();
    emit(GetAllBooks(allBooks: state.allBooks, books: state.books, total: state.total));
  }

  void _checkBloc(CheckEvent event, Emitter emitter) async {
    emit(BookLoading(allBooks: state.allBooks, books: state.books,total: state.total));

    emit(CheckState(allBooks: state.allBooks, books: state.books, total: state.total));
  }
}

