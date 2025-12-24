// lib/screens/bottom_nav_screen.dart
import 'package:flutter/material.dart';
import 'package:tp_flutter3/screens/quote_screen.dart';
import 'package:tp_flutter3/screens/responsive_home_screen.dart';
import 'package:tp_flutter3/screens/tabbar_screen.dart';
import 'library_screen.dart';
import 'basket_screen.dart';
import '../widgets/custom_drawer.dart';

class BottomNavScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final int initialIndex;

  const BottomNavScreen({super.key, required this.onToggleTheme, this.initialIndex = 0,});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  late int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }
  final List<Widget> pages =  [
    ResponsiveHomeScreen(),
    //HomeContent(),
    LibraryScreen(),
    BasketScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Store INSAT'),
        actions: [
          IconButton(
            icon: const Icon(Icons.format_quote),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const QuoteScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme,
          ),
        ],

      ),
      drawer: CustomDrawer(
        'Use TabBar',
        const Icon(Icons.menu),
            () {
          Navigator.of(context).pop();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => TabBarScreen(
                onToggleTheme: widget.onToggleTheme,
                initialIndex: _currentIndex, //
              ),
            ),
          );        },
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) => setState(() => _currentIndex = value),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_outline), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_basket), label: 'Basket'),


        ],
      ),
    );
  }
}
