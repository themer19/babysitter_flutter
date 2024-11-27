import 'package:app/barrenav/accu.dart';
import 'package:flutter/material.dart';

class Bar extends StatefulWidget {
  const Bar({super.key});

  @override
  State<Bar> createState() => _BarState();
}

class _BarState extends State<Bar> {
  int _currentIndex = 0; // Indice de l'onglet sélectionné

  // Définir une liste de pages, chaque page correspondant à un bouton
  final List<Widget> _pages = [
    Accu(), // Page d'accueil
    RecherchePage(), // Page de recherche
    ProfilPage(),
    ProfilPage(), // Page de profil
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _pages[_currentIndex], // Afficher la page sélectionnée
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex, // Indice de l'onglet actif
          onTap: (index) {
            setState(() {
              _currentIndex = index; // Met à jour l'indice actif
            });
          },
          selectedItemColor:
              Colors.pink, // Couleur des icônes sélectionnées (rose)
          unselectedItemColor:
              Colors.grey, // Couleur des icônes non sélectionnées (gris)
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Carte',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.child_friendly),
              label: "Mes enfants",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: "Messanger",
            ),
          ],
        ),
      ),
    );
  }
}

// Page d'Accueil
class AccueilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Page Accueil',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

// Page de Recherche
class RecherchePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Page Recherche',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

// Page de Profil
class ProfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Page Profil',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
