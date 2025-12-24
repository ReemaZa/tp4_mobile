import 'package:flutter/material.dart';
import 'package:tp_flutter3/screens/quote_screen.dart';
import 'package:tp_flutter3/screens/responsive_home_screen.dart';
import 'bottom_nav_screen.dart';
import 'home_content.dart';
import 'library_screen.dart';
import 'basket_screen.dart';
import '../widgets/custom_drawer.dart';

class TabBarScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final int initialIndex;

  const TabBarScreen({super.key,required this.onToggleTheme,
    this.initialIndex = 0,});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Widget> pages =  [
    ResponsiveHomeScreen(),
    //HomeContent(),
    LibraryScreen(),
    BasketScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: pages.length,
      vsync: this,
      initialIndex: widget.initialIndex,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store INSAT'),
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

        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.home_outlined), text: 'Home'),
            Tab(icon: Icon(Icons.bookmark_outline), text: 'Library'),
            Tab(icon: Icon(Icons.shopping_bag), text: 'Basket'),

          ],
        ),
      ),
      drawer: CustomDrawer(
        'Use bottom Navigation',
        const Icon(Icons.menu),
            () {
          Navigator.of(context).pop();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => BottomNavScreen(
                onToggleTheme: widget.onToggleTheme,
                initialIndex: _tabController.index, //  index courant
              ),
            ),
          );        },
      ),
      body: TabBarView(
        controller: _tabController,
        children: pages,
      ),
    );
  }
}
