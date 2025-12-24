// lib/screens/signup_screen.dart
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/basket_notifier.dart';
import '../services/user_service.dart';
import '../widgets/custom_input_decoration.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserService userService = UserService();

  void testSharedPrefs() async {
    User u = User(
      email: "test@insat.tn",
      fullName: "INSAT Student",
    );

    await userService.saveCurrentUser(u);

    User? loadedUser = await userService.getCurrentUser();
    print(loadedUser?.email);
    print(loadedUser?.fullName);

    await userService.clearCurrentUser();
  }

  // Variables pour stocker les valeurs sauvegardées par onSaved
  String _username = '';
  String _email = '';
  String _password = '';
  String _birthDate = '';
  String _address = '';

  bool _obscurePassword = true;

  // validator simple pour email
  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) return 'Email should not be empty';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store INSAT'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey, // clé pour accéder au FormState (validate/save)
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            children: [
              // 1) Image en haut
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Image.asset(
                  'assets/logo_insat.jpg',
                  width: 250,
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 8),

              // 2) Username
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: CustomInputDecoration(
                    'UserName',
                    'Enter Your UserName',
                    const Icon(Icons.person_3_outlined),
                  ).customInputDecoration(),
                  onSaved: (newValue) => _username = newValue?.trim() ?? '',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'UserName should not be empty';
                    }
                    return null;
                  },
                ),
              ),

              // 3) Email
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: CustomInputDecoration(
                    'Email',
                    'Enter Your Email',
                    const Icon(Icons.email_outlined),
                  ).customInputDecoration(),
                  onSaved: (newValue) => _email = newValue?.trim() ?? '',
                  validator: _emailValidator,
                ),
              ),

              // 4) Password
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  obscureText: _obscurePassword,
                  decoration: CustomInputDecoration(
                    'Password',
                    'Enter Your Password',
                    const Icon(Icons.lock_outline),
                  ).customInputDecoration().copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  onSaved: (newValue) => _password = newValue ?? '',
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Password should not be empty';
                    if (value.length < 8) return 'Password must be at least 8 characters';
                    return null;
                  },
                ),
              ),

              // 5) Birth Date
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: CustomInputDecoration(
                    'Birth Date',
                    'DD/MM/YYYY',
                    const Icon(Icons.calendar_today),
                  ).customInputDecoration(),
                  onSaved: (newValue) => _birthDate = newValue?.trim() ?? '',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Birth Date should not be empty';
                    }
                    final regex = RegExp(r'^\d{2}\/\d{2}\/\d{4}$');
                    if (!regex.hasMatch(value.trim())) {
                      return 'Enter date as DD/MM/YYYY';
                    }
                    return null;
                  },
                ),
              ),

              // 6) Address
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: CustomInputDecoration(
                    'Address',
                    'Enter Your Address',
                    const Icon(Icons.home_outlined),
                  ).customInputDecoration(),
                  onSaved: (newValue) => _address = newValue?.trim() ?? '',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Address should not be empty';
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 16),

              // 7) Submit button
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      //  Créer l'utilisateur à partir du formulaire
                      User user = User(
                        email: _email,
                        fullName: _username,
                      );

                      //  Sauvegarder dans SharedPreferences
                      await userService.saveCurrentUser(user);
                        //  notifier que l'utilisateur a changé
                      BasketNotifier.notifyChange();
                      // Relire l'utilisateur sauvegardé
                      User? loadedUser = await userService.getCurrentUser();
                      print("Loaded User Email: ${loadedUser?.email}");
                      print("Loaded User Name: ${loadedUser?.fullName}");

                      //  Afficher le dialog
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('SignUp'),
                            content: const Text('User added successfully! check your inbox'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please correct the errors in the form')),
                      );
                    }
                  }
                  ,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    child: Text('Submit', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
