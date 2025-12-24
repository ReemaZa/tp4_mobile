import 'package:tp_flutter3/services/user_service.dart';

import '../models/book.dart';
import 'basket_notifier.dart';
import 'database_helper.dart';

class BookService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // CREATE
  Future<void> insertBook(Book book) async {
    final db = await _dbHelper.database;
    final user = await UserService().getCurrentUser();
    final email = user?.email;
    final bookWithUser = Book(
      name: book.name,
      price: book.price,
      image: book.image,
      userEmail: email,
    );

    await db.insert('book', bookWithUser.toMap());
    BasketNotifier.notifyChange(); // 🔔 notification

  }

  // READ (panier)
  Future<List<Book>> fetchBasketBooks({String? userEmail}) async {
    final db = await _dbHelper.database;

    final result = userEmail == null
        ? await db.query('book')
        : await db.query(
      'book',
      where: 'user_email = ?',
      whereArgs: [userEmail],
    );

    return result.map((e) => Book.fromMap(e)).toList();
  }

  // DELETE
  Future<void> deleteBook(int id) async {
    final db = await _dbHelper.database;

    await db.delete(
      'book',
      where: 'id = ?',
      whereArgs: [id],
    );

    BasketNotifier.notifyChange();
  }

  // CLEAR basket
  Future<void> clearBasket() async {
    final db = await _dbHelper.database;
    await db.delete('book');
  }
}
