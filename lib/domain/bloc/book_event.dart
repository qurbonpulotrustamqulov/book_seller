part of 'book_bloc.dart';

abstract class BookEvent extends Equatable {
   const BookEvent();

   @override
  List<Object?> get props => [];
}

class AddQuantityEvent extends BookEvent{
  final BookItem bookItem;
  const AddQuantityEvent({required this.bookItem});
  @override
  List<Object?> get props => [bookItem];
}
class RemoveQuantityEvent extends BookEvent{
 final BookItem bookItem;
  const RemoveQuantityEvent({required this.bookItem});
  @override
  List<Object?> get props => [bookItem];
}
class AddTotalEvent extends BookEvent{
  final BookItem bookItem;
  final int sum;
  const AddTotalEvent({required this.sum, required this.bookItem});
  @override
  List<Object?> get props => [sum];
}
class RemoveTotalEvent extends BookEvent{
  final num sum;
  final BookItem bookItem;

  const RemoveTotalEvent({required this.sum, required this.bookItem});
  @override
  List<Object?> get props => [sum];
}
class GetAllBookEvent extends BookEvent{
  const GetAllBookEvent();

  @override
  List<Object?> get props => [];
}
class CheckEvent extends BookEvent{
  const CheckEvent();
  @override
  List<Object?> get props => [];
}