import 'package:flutter/material.dart';
import '../services/basket_notifier.dart';
import '../services/book_service.dart';
import '../models/book.dart';
import '../services/user_service.dart';
import '../widgets/home_cell.dart';
class BasketScreenLocalStorage extends StatefulWidget {
  const BasketScreenLocalStorage({super.key});

  @override
  State<BasketScreenLocalStorage> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreenLocalStorage> {
  late Future<List<Book>> _futureBooks;

  @override
  void initState() {
    super.initState();
    _loadBasket();

    BasketNotifier.basketVersion.addListener(() {
      _loadBasket(); //  refresh auto
    });
  }

  Future<void> _loadBasket() async {
    final user = await UserService().getCurrentUser();
    setState(() {
      _futureBooks =
          BookService().fetchBasketBooks(userEmail: user?.email);
    });
  }


  @override
  void dispose() {
    BasketNotifier.basketVersion.removeListener(_loadBasket);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: _futureBooks,
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
            book: books[i],
            onDelete: () async {
              await BookService().deleteBook(books[i].id!);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Livre supprimé du panier")),
              );
            },
          ),
        );
      },
    );
  }
}
