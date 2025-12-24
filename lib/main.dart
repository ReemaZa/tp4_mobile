// lib/main.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tp_flutter3/screens/intro_screen.dart';
import 'firebase_options.dart';
import 'screens/library_screen.dart';
import 'screens/details_screen.dart';
import 'screens/bottom_nav_screen.dart';
import 'screens/tabbar_screen.dart';
import 'screens/basket_screen.dart';
import 'screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  runApp(const MyApp());
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;
  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      centerTitle: true,
    ),
  );

  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue,

    scaffoldBackgroundColor: const Color(0xFF2A2929),

    cardColor: const Color(0xFF1E1E1E),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white70),
      bodyMedium: TextStyle(color: Colors.white70),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),

    listTileTheme: const ListTileThemeData(
      textColor: Colors.white70,
      iconColor: Colors.white,
    ),
  );


  void toggleTheme() {
    setState(() {
      isDark = !isDark;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Store INSAT',
      debugShowCheckedModeBanner: false,
      theme: isDark ? darkTheme : lightTheme,

      home: const IntroScreen(),

      // on définit une route initiale ;
      //initialRoute: '/bottomNav',
      routes: {
        LibraryScreen.routeName: (context) => const LibraryScreen(),
        // Routes nommées — Details attendra un argument (Book) ; on gère ci-dessous dans onGenerateRoute
        '/bottomNav': (context) =>  BottomNavScreen(onToggleTheme: toggleTheme),
        '/tabbar': (context) => TabBarScreen(onToggleTheme: toggleTheme),
        '/basket': (context) =>  BasketScreen(),
        '/signup': (context) => const SignUpScreen(),
      },
      // onGenerateRoute pour gérer une route nommée avec arguments (DetailsScreen)
      onGenerateRoute: (settings) {
        if (settings.name == DetailsScreen.routeName) {
          final args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return DetailsScreen.fromRouteArgs(args);
            },
            settings: settings,
          );
        }
        return null; // laisse flutter gérer les autres
      },
    );
  }
}
