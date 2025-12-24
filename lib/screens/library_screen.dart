// lib/screens/library_screen.dart
import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/library_cell.dart';
import 'details_screen.dart';

class LibraryScreen extends StatelessWidget {
  static const routeName = '/library';
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final books = [
      Book(name: "L'ombre du vent", price : 40,image :  'assets/lombre_du_vent.jpg'),
      Book(name: "La Prof McFADDEN",price: 50, image :'assets/la_prof.jpg'),
      Book(name: "Le prisonnier du ciel", price : 40, image :'assets/le_prisonier.jpg'),
      Book(name: "L'ombre du vent",  price :40, image :'assets/lombre_du_vent.jpg'),
      Book(name: "La Prof McFADDEN",  price : 50,image : 'assets/la_prof.jpg'),
      Book(name: "Le prisonnier du ciel", price :40, image :'assets/le_prisonier.jpg'),

    ];

    return Scaffold(
      /*appBar: AppBar(
        title: const Text("Library", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),*/
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GridView.builder(
          itemCount: books.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 colonnes
            childAspectRatio: 0.72, // ajuster la hauteur des tuiles
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final book = books[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DetailsScreen(book: book)),
                );
              },
              child: LibraryCell(book: book),
            );
          },
        ),
      ),
    );
  }
}
