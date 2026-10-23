
import 'package:flutter/material.dart';
import '../data/livres_data.dart';
import '../main.dart';

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nouveautes =
        livres.where((livre) => livre.nouveaute == true).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Nouveautés',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 160,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: nouveautes.map((livre) {
                return Container(
                  width: 110,
                  margin: const EdgeInsets.all(8),
                  color: livre.couleur,
                  alignment: Alignment.center,
                  child: Text(
                    livre.titre,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Tout le catalogue',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: livres.length,
              itemBuilder: (context, index) {
                return livreTile(livres[index]);
              },
              separatorBuilder: (context, index) {
                return const Divider(indent: 72);
              },
            ),
          ),
        ],
      ),
    );
  }
}
