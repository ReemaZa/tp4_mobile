// lib/screens/home_content.dart
import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/home_cell.dart';
import 'details_screen.dart';
import 'library_screen.dart';
import '../widgets/custom_drawer.dart';

class HomeContent extends StatelessWidget {
  static const routeName = '/';
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final books = [
      Book(name: "L'ombre du vent", price : 40,image :  'assets/lombre_du_vent.jpg'),
      Book(name: "La Prof McFADDEN",price: 50, image :'assets/la_prof.jpg'),
      Book(name: "Le prisonnier du ciel", price : 40, image :'assets/le_prisonier.jpg'),
      Book(name: "L'ombre du vent",  price :40, image :'assets/lombre_du_vent.jpg'),
      Book(name: "La Prof McFADDEN",  price : 50,image : 'assets/la_prof.jpg'),
      Book(name: "Le prisonnier du ciel", price :40, image :'assets/le_prisonier.jpg'),
      Book(name: "Le prisonnier du ciel22", price :40, image :'assets/le_prisonier.jpg'),

    ];


      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return HomeCell(
                book: book,
                onTap: () {
                  // Exemple 1 : route normale (push)
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsScreen(book: book)));

                  // Exemple 2 : route nommée (pushNamed) -> on envoie l'objet Book via arguments
                  Navigator.pushNamed(context, DetailsScreen.routeName, arguments: book);
                },
              );
            },
          ),
        ),
      );

  }
}