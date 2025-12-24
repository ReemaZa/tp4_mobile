import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/home_cell.dart';
import 'details_screen.dart';

class ResponsiveHomeScreen extends StatefulWidget {
  const ResponsiveHomeScreen({super.key});

  @override
  State<ResponsiveHomeScreen> createState() => _ResponsiveHomeScreenState();
}

class _ResponsiveHomeScreenState extends State<ResponsiveHomeScreen> {
  Book? selectedBook;

  final List<Book>  books = [
    Book(name: "L'ombre du vent", price : 40,image :  'assets/lombre_du_vent.jpg'),
    Book(name: "La Prof McFADDEN",price: 50, image :'assets/la_prof.jpg'),
    Book(name: "Le prisonnier du ciel", price : 40, image :'assets/le_prisonier.jpg'),
    Book(name: "L'ombre du vent",  price :40, image :'assets/lombre_du_vent.jpg'),
    Book(name: "La Prof McFADDEN",  price : 50,image : 'assets/la_prof.jpg'),
    Book(name: "Le prisonnier du ciel", price :40, image :'assets/le_prisonier.jpg'),
    Book(name: "Le prisonnier du ciel22", price :40, image :'assets/le_prisonier.jpg'),

  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // PETIT ÉCRAN
        if (constraints.maxWidth < 600) {
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];

              return HomeCell(
                book: books[index],
                onTap: () {
                  // Exemple 1 : route normale (push)
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsScreen(book: book)));

                  // Exemple 2 : route nommée (pushNamed) -> on envoie l'objet Book via arguments
                  Navigator.pushNamed(context, DetailsScreen.routeName, arguments: book);
                },
              );
            },
          );
        }

        // GRAND ÉCRAN (multi-pane)
        return Row(
          children: [
            // panneau gauche : liste
            Expanded(
              flex: 2,
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return HomeCell(
                    book: books[index],
                    onTap: () {
                      setState(() {
                        selectedBook = books[index];
                      });
                    },
                  );
                },
              ),
            ),

            // panneau droit : détails
            Expanded(
              flex: 3,
              child: selectedBook == null
                  ? const Center(child: Text("Select a book"))
                  : _DetailsPane(book: selectedBook!),
            ),
          ],
        );
      },
    );
  }
}

class _DetailsPane extends StatelessWidget {
  final Book book;

  const _DetailsPane({required this.book});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Image.asset(book.image, width: 200),
          const SizedBox(height: 20),
          Text(book.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text("${book.price} TND",
              style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}

