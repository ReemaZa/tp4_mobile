// lib/widgets/custom_drawer.dart
import 'package:flutter/material.dart';
class CustomDrawer extends StatelessWidget {
  final String buttonTitle;
  final Icon icon;
  final VoidCallback onPressed;

  const CustomDrawer(this.buttonTitle, this.icon, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      backgroundColor: theme.scaffoldBackgroundColor,
      child: Column(
        children: [
          DrawerHeader(

            child: Center(
              child: Image.asset('assets/logo_insat.jpg', width: 100),
            ),
          ),
          ListTile(
            leading: icon,
            title: Text(buttonTitle, style: theme.textTheme.bodyMedium),
            onTap: onPressed,
          ),
          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text('SignUp'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/signup');
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Store INSAT', style: theme.textTheme.bodySmall),
          )
        ],
      ),
    );
  }
}
