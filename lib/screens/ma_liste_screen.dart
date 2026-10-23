
import 'package:flutter/material.dart';
import '../data/livres_data.dart';
import '../models/livre.dart';

class MaListeScreen extends StatefulWidget {
  const MaListeScreen({super.key});

  @override
  State<MaListeScreen> createState() => _MaListeScreenState();
}

class _MaListeScreenState extends State<MaListeScreen> {
  bool _nouveautesSeulement = false;

  Map<String, bool> _genres = {
    'Roman': true,
    'Science': true,
    'Histoire': true,
    'Jeunesse': true,
    'Informatique': true,
  };

  IconData iconeGenre(String genre) {
    switch (genre) {
      case 'Roman':
        return Icons.menu_book;
      case 'Science':
        return Icons.science;
      case 'Histoire':
        return Icons.history_edu;
      case 'Jeunesse':
        return Icons.child_care;
      case 'Informatique':
        return Icons.computer;
      default:
        return Icons.book;
    }
  }

  bool? get tousLesGenres {
    if (_genres.values.every((valeur) => valeur)) {
      return true;
    }

    if (_genres.values.every((valeur) => !valeur)) {
      return false;
    }

    return null;
  }

  List<Livre> get livresFiltres {
    return livres.where((livre) {
      final genreSelectionne = _genres[livre.genre] ?? false;
      final nouveauteAcceptee =
          !_nouveautesSeulement || livre.nouveaute;

      return genreSelectionne && nouveauteAcceptee;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final liste = livresFiltres;
    final nombreLus = liste.where((livre) => livre.lu).length;
    final nombreAffiches = liste.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lus : $nombreLus / $nombreAffiches'),
      ),
      body: ListView(
        children: [
          CheckboxListTile(
            title: const Text('Afficher uniquement les nouveautés'),
            value: _nouveautesSeulement,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (bool? valeur) {
              setState(() {
                _nouveautesSeulement = valeur ?? false;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Tous les genres'),
            tristate: true,
            controlAffinity: ListTileControlAffinity.leading,
            value: tousLesGenres,
            onChanged: (bool? valeur) {
              setState(() {
                final bool cocher = valeur != true;
                _genres.updateAll((genre, ancien) => cocher);
              });
            },
          ),
          const Divider(),
          ..._genres.keys.map((genre) {
            final nombreLivres =
                livres.where((livre) => livre.genre == genre).length;

            return CheckboxListTile(
              title: Text(genre),
              subtitle: Text('$nombreLivres livres'),
              secondary: Icon(iconeGenre(genre)),
              activeColor: Colors.blue,
              controlAffinity: ListTileControlAffinity.leading,
              value: _genres[genre],
              onChanged: (bool? valeur) {
                setState(() {
                  _genres[genre] = valeur ?? false;
                });
              },
            );
          }),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Mes livres',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...List.generate(liste.length, (index) {
            final livre = liste[index];

            return CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                livre.titre,
                style: TextStyle(
                  decoration: livre.lu
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              subtitle: Text('${livre.auteur} – ${livre.annee}'),
              secondary: CircleAvatar(
                backgroundColor: livre.couleur,
                child: const Icon(
                  Icons.menu_book,
                  color: Colors.white,
                ),
              ),
              value: livre.lu,
              onChanged: (bool? valeur) {
                setState(() {
                  livre.lu = valeur ?? false;
                });
              },
            );
          }),
        ],
      ),
    );
  }
}
