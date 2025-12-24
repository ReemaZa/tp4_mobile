import 'package:flutter/material.dart';
import '../models/book_fs.dart';
import '../services/book_fs_service.dart';
import '../services/user_service.dart';
class FirebaseBooksWidget extends StatelessWidget {
  final BookFsService service = BookFsService();

  FirebaseBooksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserService().getCurrentUser(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = snapshot.data!;
        return StreamBuilder<List<BookFs>>(
          stream: service.streamBooks(user.email!),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final books = snapshot.data!;
            if (books.isEmpty) {
              return const Center(child: Text("No books"));
            }

            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (_, i) {
                final book = books[i];
                return Card(
                  child: ListTile(
                    leading: Image.asset(book.image, width: 50),
                    title: Text(book.name),
                    subtitle: Text("${book.price} TND"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => service.deleteBook(book.id),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
