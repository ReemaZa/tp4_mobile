import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book_fs.dart';

class BookFsService {
  final CollectionReference _booksRef =
      FirebaseFirestore.instance.collection('books');

  // CREATE
  Future<void> addBook(BookFs book) async {
    await _booksRef.add(book.toFirestore());
  }

  // READ (STREAM temps réel)
  Stream<List<BookFs>> streamBooks(String userEmail) {
    return _booksRef
        .where('userEmail', isEqualTo: userEmail)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) =>
              BookFs.fromFirestore(
                doc.data() as Map<String, dynamic>,
                doc.id,
              )
            ).toList()
        );
  }

  // DELETE
  Future<void> deleteBook(String id) async {
    await _booksRef.doc(id).delete();
  }

  // UPDATE
  Future<void> updateBook(BookFs book) async {
    await _booksRef.doc(book.id).update(book.toFirestore());
  }
}
