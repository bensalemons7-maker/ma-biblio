
import 'package:flutter/material.dart';

class ParametresScreen extends StatelessWidget {
  const ParametresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Mon profil'),
            subtitle: const Text('Nom, e-mail, mot de passe'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profil sélectionné'),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            tileColor: Colors.blue.shade50,
            iconColor: Colors.blue,
            textColor: Colors.blue.shade900,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Notifications sélectionnées'),
                ),
              );
            },
          ),
          const ListTile(
            leading: Icon(Icons.language),
            title: Text('Langue'),
            subtitle: Text('Français'),
          ),
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('À propos'),
            subtitle: Text(
              'Application MaBiblio\nBibliothèque de quartier',
            ),
            dense: true,
            isThreeLine: true,
          ),
        ],
      ),
    );
  }
}
