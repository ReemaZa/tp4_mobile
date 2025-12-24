// lib/screens/details_screen.dart
import 'package:flutter/material.dart';
import '../models/book.dart';
import '../globals.dart' as globals;
import '../models/book_fs.dart';
import '../services/book_fs_service.dart';
import '../services/user_service.dart';

class DetailsScreen extends StatefulWidget {
  static const routeName = '/details';

  final Book? book;
  const DetailsScreen({super.key, this.book});

  // méthode utilitaire pour construire depuis settings.arguments
  static DetailsScreen fromRouteArgs(Object? args) {
    if (args is Book) {
      return DetailsScreen(book: args);
    } else {
      // fallback: un Book par défaut pour éviter crash
      return const DetailsScreen();
    }
  }

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final book = widget.book ??
        Book(
          name: "No Book",
          price: 0,
          image: 'assets/ombreduvent.jpg',
        );
    return Scaffold(
      appBar: AppBar(title: Text(book.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(book.image, height: 320, fit: BoxFit.cover),
          ),
          const SizedBox(height: 16),
          const Text(
            "Description...",
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 16),
          Text("${book.price} TND", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            // with local storage
            /*onPressed: () async {
              try {
                // Ajouter le livre à la base
                await BookService().insertBook(book);

                //  Feedback utilisateur
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Livre ajouté au panier')),
                );

              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Erreur lors de l\'ajout : $e')),
                );
              }
            },*/
            // avec firebase
          onPressed: () async {
    final user = await UserService().getCurrentUser();
    if (user == null) return;

    final bookFs = BookFs(
    id: '',
    name: book.name,
    price: book.price,
    image: book.image,
    userEmail: user.email!,
    );

    await BookFsService().addBook(bookFs);

    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Livre ajouté (Firebase)')),
    );
    },

    icon: const Icon(Icons.shopping_bag),
            label: const Text('Purchase'),
          ),

          const SizedBox(height: 8),
          Text("Quantity (globale) : ${globals.quantity}"),
        ],
      ),
    );
  }
}
