import 'package:flutter/material.dart';
import '../models/book_fs.dart';
import '../services/book_fs_service.dart';
import '../services/user_service.dart';
import '../widgets/home_cell.dart';
class BasketScreen extends StatelessWidget {
  BasketScreen({super.key});

  final BookFsService service = BookFsService();

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
              return const Center(child: Text("Basket is empty"));
            }

            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (_, i) => HomeCell(
                book: books[i].toLocal(), // conversion si besoin
                onDelete: () async {
                  await service.deleteBook(books[i].id);
                },
              ),
            );
          },
        );
      },
    );
  }
}
